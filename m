Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422787AbWA1Bxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422787AbWA1Bxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422788AbWA1Bxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:53:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42148 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422787AbWA1Bxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:53:39 -0500
Date: Fri, 27 Jan 2006 20:53:10 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
cc: Al Viro <viro@ftp.linux.org.uk>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43DA2795.707@ti-wmc.nl>
Message-ID: <Pine.LNX.4.64.0601272046410.3192@evo.osdl.org>
References: <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
 <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com>
 <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl>
 <20060127133939.GU27946@ftp.linux.org.uk> <43DA2795.707@ti-wmc.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Jan 2006, Simon Oosthoek wrote:
> 
> really? if it was dual licensed (that's what I meant, perhaps the "or" should
> be an "and"? ;-), v2 in the kernel and v3(or any later version, etc.), if the
> code is used outside of the kernel, it would "fall back to" v3+ as soon as
> it's taken out of the kernel and used in something else.

You very much _can_ dual-license it, and say "for the kernel, we license 
it under GPLv2".

But if you do that, then the GPLv2 licensing in the kernel means that 
somebody else can take it from the kernel, and ti can still be under the 
GPLv2 too (_and_ the GPLv3, for that matter - the kernel GPLv2 license in 
no way takes away the ability to use it in any other way that you've 
dual-licensed it).

In other words, you cannot say "outside of the kernel, you ahve to use the 
GPLv3", because the GPLv2 usage _inside_ of the kernel requires that the 
GPLv2 also be usable outside of it.

But you most definitely _can_ dual-license in general. It's perfectly fine 
to license something under the GPLv2 and allow redistribution with the 
kernel, _and_ have the same code as part of some other project under 
GPLv3.

It's just that you cannot limit the kernel version to just a kernel 
project. Somebody can (at any time) take the Linux kernel, and turning it 
into some totally other GPL-v2-licensed project.

(This really is not at all specific to the GPLv3 - the same thing holds 
for any other dual licensing with the GPL. You  cannot license your 
proprietary code to be "GPL only within the kernel, and proprietary 
anywhere else". The GPL inherently requires that the code can be used in 
another project).

		Linus
