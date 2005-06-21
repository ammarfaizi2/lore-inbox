Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVFUNCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVFUNCX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVFUNBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:01:44 -0400
Received: from [85.8.12.41] ([85.8.12.41]:11192 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261380AbVFUNA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:00:29 -0400
Message-ID: <42B80F40.8000609@drzeus.cx>
Date: Tue, 21 Jun 2005 14:59:44 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
References: <42B7F740.6000807@drzeus.cx> <Pine.LNX.4.61.0506211413570.3728@scrub.home> <42B80AF9.2060708@drzeus.cx> <Pine.LNX.4.61.0506211451040.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0506211451040.3728@scrub.home>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

>
>http://linux.bkbits.net/ still works.
>
>  
>

Thanks.

It should only be a matter of reversing the patches for Solaris then.
But that will of course bring back the warnings on that platform. I'd
say we should stick with what the standard says. Unfortunatly I don't
have access to the standard so I wouldn't know which is the correct
version. If I'd have to guess I'd say the odds are in favor of glibc
getting it more right than solaris.

Should I extract the changes for bkbits and make a reversed patch?

Rgds
Pierre

