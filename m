Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289185AbSA1Oj4>; Mon, 28 Jan 2002 09:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289186AbSA1Ojq>; Mon, 28 Jan 2002 09:39:46 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:16833 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289185AbSA1Oja>; Mon, 28 Jan 2002 09:39:30 -0500
Date: Mon, 28 Jan 2002 16:34:15 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: pierre.rousselet@wanadoo.fr
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 fs corruption and usb devices
Message-ID: <Pine.LNX.4.44.0201281631110.20095-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Warning (Oops_read): Code line not seen, dumping what data is available

You need to get the whole oops output...

> >>EIP; c0140754 <inode_change_ok+24/128>   <=====
>Trace; d08b959c <[speedtch]udsl_usb_driver+1c/40>
>Trace; d089ea1c <[usbcore]free_inode+7c/84>
>Trace; d089f870 <[usbcore]usbdevfs_remove_device+30/d8>

Isn't that a proprietory driver you have there? Who knows what lurks in 
the inner depths of that cruft, i'd ask you to reproduce it without 
loading that driver, but then that would be pointless for your situation. 
I suggest you take it up with Alcatel...

Regards,
	Zwane Mwaikambo


