Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268396AbTCCHQg>; Mon, 3 Mar 2003 02:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268399AbTCCHQg>; Mon, 3 Mar 2003 02:16:36 -0500
Received: from [196.12.44.6] ([196.12.44.6]:12760 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S268396AbTCCHQf>;
	Mon, 3 Mar 2003 02:16:35 -0500
Date: Mon, 3 Mar 2003 12:58:24 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: redirecting printk to the Serial port
In-Reply-To: <95740000.1046676056@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0303031255570.27683-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have seen the Documentation/serial-console.txt and accordingly gave the 
kernel arguments console=/dev/ttyS0,9600n8, but even after giving that i 
am not getting anything to the other end. To check if the serial 
communication was in place... i tried echo "abc" > /dev/ttyS0 and that 
worked.

Prasad.

On Sun, 2 Mar 2003, Martin J. Bligh wrote:

> > 	Got a silly doubt. when trying to insert one of my modules into
> > the kernel, its getting rebooted and unfortunately i am losing all the
> > debug(printk) messages.  Can i in some fashion capture all the printk's
> > through the serial port. (I have two linux boxes and a serial cable to
> > connect both of them)
> 
> See Documentation/serial-console.txt
> 
> M.
> 

-- 
Failure is not an option

