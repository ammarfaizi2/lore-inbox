Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbTLPGLn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 01:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbTLPGLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 01:11:43 -0500
Received: from [64.65.189.210] ([64.65.189.210]:64711 "EHLO
	mail.pacrimopen.com") by vger.kernel.org with ESMTP id S264987AbTLPGLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 01:11:41 -0500
Subject: Re: How to send an IP packet from the kernel
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: William Stearns <wstearns@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FDD1EB4.3020305@tait.co.nz>
References: <Pine.LNX.4.44.0312142130380.22128-100000@sparrow>
	 <3FDD1EB4.3020305@tait.co.nz>
Content-Type: text/plain
Message-Id: <1071555087.8101.1.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Dec 2003 22:11:27 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-15 at 07:38, Dmytro Bablinyuk wrote:
> >>I have a dstaddr, srcaddr and the actual data(payload). I need to load 
> >>IP packet with data(payload) and send the packet out to the net through 
> >>eth0 .
> >>How do I do this from the kernel?
> >>    
> >>
> >
> >	Why not do it from userspace, with lots of available tools ( 
> >http://www.stearns.org/doc/pcap-apps.html , 
> >http://www.stearns.org/netreply )?
> >  
> >
> For reasons that the driver will do extra stuff on this data and this 
> data not always will be/must be available to a user space app.
> Some data will be available only inside of the driver. No other 
> processing out of the driver for that data is allowed.


You trying to back door a driver or something?   You might look at AFS
kernel modules. http://www.openafs.org.  They do many things in the
kernel, and i think that some IP communications is one of them.  [But
don't quote me]

js


