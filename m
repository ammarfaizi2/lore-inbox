Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUEGQWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUEGQWf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 12:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbUEGQWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 12:22:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:37359 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263685AbUEGQWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 12:22:31 -0400
Date: Fri, 07 May 2004 09:22:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Distributions vs kernel development
Message-ID: <540670000.1083946935@[10.10.2.4]>
In-Reply-To: <20040507085312.3247d70d@dell_ss3.pdx.osdl.net>
References: <20040507085312.3247d70d@dell_ss3.pdx.osdl.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After having being burned twice: first by Mandrake and supermount, and second
> by SuSe and reiserfs attributes; are any of the distributions committed to
> making sure that their distribution will run the standard kernel? (ie. 2.6.X from
> kernel.org). When running a non-vendor kernel, I need to reasonably expect that the system
> will boot and all the filesystems and standard devices are available.  I don't
> expect every startup script to run clean, or every device that has a driver
> only in the vendor kernel to work. 
> 
> But kernel developers need to be able run a standard environment. This effects
> both day to day kernel testing and automated test environments like PLM and STP.
> I am not saying it is bad that the distributions try to satisfy their customers,
> or create a better experience; they just need to stop breaking things, and add
> running a standard kernel as part of their QA cycle.

I run Debian to do this all the time. If you run the stable distro, it doens't
have all bleeding edge desktop crap, but it does have the major advantage of
actually working, and being perfectly stable. Getting it to run 2.6 needs
a few small updates, but nothing hard. 

Testing is very solid too, has 2.6 support out of the box, and more updated 
desktop stuff (I run that on my laptop). Unstable seems more stable than most
vendors shipped distros to me, but changes more rapidly. They also seem to
break serial console occasionally in unstable by loading fonts into it 
(idiots!), but that's trivial to fix.

The fact that their own kernel packages are so close to mainline probably 
helps a lot ;-)

M.

