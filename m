Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132065AbQLNKcx>; Thu, 14 Dec 2000 05:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132142AbQLNKcn>; Thu, 14 Dec 2000 05:32:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7440 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132065AbQLNKcc>; Thu, 14 Dec 2000 05:32:32 -0500
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
To: sabre@nondot.org (Chris Lattner)
Date: Thu, 14 Dec 2000 10:02:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        lk@tantalophile.demon.co.uk (Jamie Lokier),
        viro@math.psu.edu (Alexander Viro),
        mhaque@haque.net (Mohammad A. Haque), ben@kalifornia.com (Ben Ford),
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.21.0012132025310.24483-100000@www.nondot.org> from "Chris Lattner" at Dec 13, 2000 08:42:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146VE3-00043s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a large perception of CORBA being slow, but for the most part it
> is unjustified.  I believe that the act of _designing_ a completely new
> protocol, standardizing it, and making it actually work would be a huge
> process that would basically reinvent CORBA (obviously some of the design
> decisions could be made differently, but all the same issues would have be
> dealt with).

CORBA is slow compared to some of the other solutions. The question I was 
trying to ask is whether you should put something smaller and faster into the
kernel space and leave CORBA in userland. It's complex, it has security 
implications surely it belongs talking something simple and fast to the kernel.

If you look at microkernels they talk a much simpler faster rpc protocol. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
