Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVIRVGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVIRVGY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVIRVGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:06:24 -0400
Received: from ns.firmix.at ([62.141.48.66]:47237 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932200AbVIRVGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:06:24 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: 7eggert@gmx.de
Cc: "Martin v." =?ISO-8859-1?Q?L=F6wis?= <martin@v.loewis.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E1EH4lL-0001Iz-Lx@be1.lrz>
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it>
	 <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it>
	 <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it>
	 <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it>
	 <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it>
	 <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it>
	 <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it>
	 <4O1MJ-3Hf-5@gated-at.bofh.it> <4O8Oh-5jp-7@gated-at.bofh.it>
	 <E1EH4lL-0001Iz-Lx@be1.lrz>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Sun, 18 Sep 2005 23:03:39 +0200
Message-Id: <1127077419.8395.35.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-18 at 21:23 +0200, Bodo Eggert wrote:
[...]
> >> Not sure what this has
> >> to do with the specific patch, though.
> > 
> > It is not supported by the kernel. So either you remove it or you make
> > some compatibility hack (like an appropriate sym-link
> 
> -EDOESNOTWORK
> 
> #!/usr/bin/perl -T -s -w

It depends on /usr/bin/perl how it handles a white-space character
directly after "-w".

> >, etc.). Since the
> > kernel can start java classes directly, you can probably make a similar
> > thing for the UTF-8 stuff.
> 
> If MSDOS text files are text files are legal scripts, the kernel
> should recognize [\x0D\x0A] as valid line breaks.

The Unix worls does recognize the line breaks. It's up to the tool how
to handle the white-space character before it. Especially for C and
similar languages with continuation lines this leads to interesting (or
now more boring) problems.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



