Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284460AbRLEQUD>; Wed, 5 Dec 2001 11:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283770AbRLEQRz>; Wed, 5 Dec 2001 11:17:55 -0500
Received: from [209.1.214.221] ([209.1.214.221]:32006 "EHLO
	smtparch.vistocorporation.com") by vger.kernel.org with ESMTP
	id <S283759AbRLEQRq> convert rfc822-to-8bit; Wed, 5 Dec 2001 11:17:46 -0500
Message-ID: <3C091F550002B98E@smtparch.vistocorporation.com> (added by
	    postmaster@smtparch.vistocorporation.com)
Reply-To: linuxlist@visto.com
From: "rohit prasad" <linuxlist@visto.com>
Subject: newly compiled kernel no .img file
Date: Wed, 05 Dec 2001 08:16:08 -0800
X-Mailer: Visto
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
X-Mailer: Visto Server
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

 I have recompiled the linux 2.4.7-10 kernel to get ntfs readonly support.

 this is what I entered in the lilo.conf in the fllowing order,

 NEWLY COMPILED KERNEL IMAGE
 OLD KERNEL IMAGE
 WINDOWS 	

 
 image=/boot/wmlinux-2.4.7-10
	label=xunil
	read-only
	root=/dev/hda2
 image=/boot/vmlinuz-2.4.7-10old
	label=linux
	initrd=/boot/initrd-2.4.7-10.img
	read-only
	root=/dev/hda2
other=/dev/hda1
	optional
	label=windows

If you notice the first declaration of image the 
"initrd=/boot/initrd-2.4.7-10.img" is not present . Of course I removed it so that there would be no kernel panic and I am able to boot into the new kernel (xunil). 
What I want to know is what is this .img file why is it required in the original kernel compilation and not in the newer . 

 Am I missing something here that could later on create problems.

All help will be gratefully ackd.

TIA,
Rohit
___________________________________________________________________________
Visit http://www.visto.com.
Find out  how companies are linking mobile users to the 
enterprise with Visto.

