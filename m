Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbTCFXkh>; Thu, 6 Mar 2003 18:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbTCFXkh>; Thu, 6 Mar 2003 18:40:37 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:47833 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261296AbTCFXkg>; Thu, 6 Mar 2003 18:40:36 -0500
Date: Thu, 06 Mar 2003 15:40:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: digitale@digitaleric.net, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       rml@tech9.net, mingo@elte.hu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <24000000.1046994021@flay>
In-Reply-To: <200303061730.39422.digitale@digitaleric.net>
References: <Pine.LNX.4.44.0303060931300.7206-100000@home.transmeta.com> <200303061730.39422.digitale@digitaleric.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At first I strongly dissaproved of the kernel's timeslice adjustment by 
> interactivity estimation; policy belongs in userland, I thought.  But the 

That seems to be one of the most dramatically overused misguided statements
bandied about in Linux at the moment, with respect to just about every 
subsystem, and it's really starting to get annoying.

Yes, you should be able to frig with policy decisions from userspace, if
you really want to BUT the kernel should do something pretty sane by 
default without user intervention. It's exactly the same mistake apps
keep making, and why half of them are unusable.

M.

