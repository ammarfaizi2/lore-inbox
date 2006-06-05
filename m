Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750965AbWFELHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWFELHP (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWFELHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:07:15 -0400
Received: from mailhost.netweaver.net ([213.160.118.140]:62138 "HELO
	mailhost.netweaver.net") by vger.kernel.org with SMTP
	id S1750965AbWFELHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:07:14 -0400
Date: Mon, 05 Jun 2006 12:07:06 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: USB devices fail unnecessarily on unpowered hubs
From: "Lee Dowling" <ledow@ledow.org.uk>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.tan6h41hl78ldg@p1000>
User-Agent: Opera M2/8.54 (Linux, build 1745)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This, of course, doesn't deal with outside cases.

It's common knowledge that a lot of equipment is running out of spec all  
the time because of cheap components, bad BIOS's etc.  As an example, my  
Asus L4500R laptop (with the latest ASUS BIOS) ALWAYS shows "over-current"  
under Linux on all *internal* USB ports the second ANYTHING is plugged in  
(and I have nearly 50 different USB devices of different types,  
manufacturers and quality).

The suggestion to simply stop over-current ports from working would  
immediately disable all USB ports, including any powered hubs that I plug  
into them, I assume.  I can't update the BIOS any further to stop this and  
if I could I doubt it would solve the problem (it looks like cheap  
hardware to me).  Therefore, you've just removed all my perfectly  
functional USB capability because the best BIOS I can use reports an  
incorrect error (hey, what's new?).

Windows XP, incidentally, runs flawlessly with all USB devices without  
power warnings on this laptop.  This may well be fixable somewhere else,  
it may even be a bug in the internal USB code for my laptop which may be  
help in hunting such bugs down.  However, anything like this should be  
optional and not with some convoluted command-line echo, but by as simple  
binary switch accesible to userspace.  I know what I'm doing, if I choose  
to ignore the error, that's my problem.  The fact is, if I don't ignore  
this particular error, my laptop loses all USB functionality.  Taint my  
kernel if you want (that's what the new userspace taint is for, is it  
not?) but I need to use the USB ports that I've paid a lot of money to  
have and that DO work perfectly if given a nudge.

Spec's are lovely and all, but we all know that if real hardware confirmed  
to the spec's all the time that the Linux kernel would be about half it's  
current size.

Lee Dowling
ICT Technician
