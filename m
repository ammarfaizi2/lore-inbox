Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261931AbTCGXuk>; Fri, 7 Mar 2003 18:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261933AbTCGXuf>; Fri, 7 Mar 2003 18:50:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47111 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261931AbTCGXuM>; Fri, 7 Mar 2003 18:50:12 -0500
Date: Sat, 8 Mar 2003 00:00:44 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Message-ID: <20030308000044.R17492@flint.arm.linux.org.uk>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com> <20030307233916.Q17492@flint.arm.linux.org.uk> <3E692EE4.9020905@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E692EE4.9020905@zytor.com>; from hpa@zytor.com on Fri, Mar 07, 2003 at 03:44:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:44:36PM -0800, H. Peter Anvin wrote:
> Right, of course.  However, the first step (which Greg has accomplished)
> is to get klibc merged into the kernel build.  We already have ipconfig
> and mount-nfs binaries which compile against klibc; now we need to
> integrate them so they can pick up the ip= and nfsroot= options and do
> the right thing in userspace.

Indeed - I think I made ipconfig dump out a file in a nice easy form
for other stuff to pick up on.

> *Then* we can discuss when they should be removed.

That is the order I always assumed this would happen in. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

