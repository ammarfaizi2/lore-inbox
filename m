Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUANOkC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUANOkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:40:02 -0500
Received: from server1.fast24.net ([217.10.137.141]:20660 "HELO
	server1.fast24.net") by vger.kernel.org with SMTP id S266316AbUANOj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:39:58 -0500
Message-ID: <400554C3.4060600@sms.ed.ac.uk>
Date: Wed, 14 Jan 2004 14:40:03 +0000
From: Michael Lothian <s0095670@sms.ed.ac.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Catch 22
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just thaought I'd let you know about my experiences with Mandrake using
the 2.4 and 2.6 kernels on my new hardware which is primaraly a Asus
A7V600 (KT600) Motherboard and Radeon 9600XT

Under 2.4 my ATA hard drak is mounted under /dev/hda where as under 2.6
is /dev/hde so there is no wasy way to switch between them with lilo and
/etc/fstab needing to be changed

My gigabit lan isn't deteced at all under 2.4 is works but with errors
in 2.6 (I've tried building the 2.4 mdoule for it but it crashes the
whole system)

Agpgart in 2.4 isn't new enough to cope with the KT600 motherboard in
2.6 it is but the fglrx driver won't compile properly using it so either
way no kewl 3D graphics (oh and it only works in 2D mode if I'm using
Xfree86 4.3) if I use the older Alt driver I can get it to work with 4.4
but still without 3D

My webcam (cpia usb) is detected and works perfectly under 2.4 in 2.6 it
simply doesn't appear at all.

My DVB card works perfectly in 2.4 however under 2.6 /dev/dvb is totally
empty after modprobing the correct drivers (tda1004x frontend)

So I'm kinda caught in the middle here. I don't have a fully working
system no matter which kernel I use

Has anyone had any sililar experiences or found some solutions

Mike
