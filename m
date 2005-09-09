Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVIIIkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVIIIkR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVIIIkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:40:17 -0400
Received: from mail.suse.de ([195.135.220.2]:17291 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932537AbVIIIkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:40:16 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH] x86-64 CFI annotation fixes and additions
Date: Fri, 9 Sep 2005 10:40:11 +0200
User-Agent: KMail/1.8
Cc: "Jan Beulich" <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43207A6302000078000244F4@emea1-mh.id2.novell.com>
In-Reply-To: <43207A6302000078000244F4@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091040.11405.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 17:52, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
>
> Being the foundation for reliable stack unwinding, this fixes CFI
> unwind
> annotations in many low-level x86_64 routines, plus a config option
> (available to all architectures, and also present in the previously
> sent
> patch adding such annotations to i386 code) to enable them separatly
> rather than only along with adding full debug information.

Thanks.

The UNWIND_INFO part has still some problems - in particular it is lying
on all other architectures which don't check it yet. I made it dependent
on X86_64 right now.

-Andi


P.S.: Can you perhaps add a From: Jan B ... 
line to the attachments? Otherwise i need to always edit them by hand to
get the authorship right.
