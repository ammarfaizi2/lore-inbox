Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWCYSro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWCYSro (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWCYSro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:47:44 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:33667 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932214AbWCYSrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:47:43 -0500
Date: Sat, 25 Mar 2006 19:47:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mikado <mikado4vn@gmail.com>
cc: linux-c-programming@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Virtual Serial Port
In-Reply-To: <442582B8.8040403@gmail.com>
Message-ID: <Pine.LNX.4.61.0603251945100.29793@yvahk01.tjqt.qr>
References: <442582B8.8040403@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>My machine has only one serial port. Now I want to add more *software*
>(virtual) serial ports. I also want to make a virtual serial cable
>between a real serial port and a virtual one OR between virtual ports.
>Is there any way to solve that problem in our universe?

You could write a device driver implementing virtual serial ports. Then you 
just add an ioctl that connects/disconnects virtual ports to real ports if 
desired.
I do not quite see what this would be good for, but I am sure it's 
good for learning or for fun. :)



Jan Engelhardt
-- 
