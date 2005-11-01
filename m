Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVKAANm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVKAANm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbVKAANm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:13:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964911AbVKAANl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:13:41 -0500
Date: Mon, 31 Oct 2005 16:13:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Roman Zippel <zippel@linux-m68k.org>, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
In-Reply-To: <20051031160557.7540cd6a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
 <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org>
 <200510310341.02897.ak@suse.de> <Pine.LNX.4.61.0511010039370.1387@scrub.home>
 <20051031160557.7540cd6a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 31 Oct 2005, Andrew Morton wrote:
> 
> Are you sure these kernels are feature-equivalent?

They may not be feature-equivalent in reality, but it's hard to generate 
something that has the features (or lack there-of) of old kernels these 
days. Which is problematic.

But some of it is likely also compilers. gcc does insane padding in many 
cases these days. 

And a lot of it is us just being bloated. Argh.

		Linus
