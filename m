Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbSLBVCX>; Mon, 2 Dec 2002 16:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265228AbSLBVCX>; Mon, 2 Dec 2002 16:02:23 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:32270 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265196AbSLBVCW>; Mon, 2 Dec 2002 16:02:22 -0500
Date: Mon, 2 Dec 2002 21:09:45 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Alberto Ornaghi <alor@iol.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.50] problems with framebuff and vesafb
In-Reply-To: <5.1.1.5.2.20021130152506.02922d50@popmail.iol.it>
Message-ID: <Pine.LNX.4.44.0212022109240.20834-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If I enable the CONFIG_VIDEO_SELECT option  and the I pass the vga=791 thru 
> LILO, I cannot see any message while the kernel boots and while 
> running.  the kernel is live, the only problem is that the video seems 
> turned off. (I can blindly log in the system and type a reboot)
> 
> I suppose this is a regression since my 2.4.20 is working fine with that 
> option and I can use my 1024x768 framebuffer console.
> 
> I have an S3 savage twister-K, and since there isn't a native driver for 
> it, I'm using the vesafb driver.

Try my latest patch. It fixes many many things.


