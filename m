Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVCWK00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVCWK00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVCWK00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:26:26 -0500
Received: from grunt1.ihug.co.nz ([203.109.254.41]:14573 "EHLO
	grunt1.ihug.co.nz") by vger.kernel.org with ESMTP id S261503AbVCWK0S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:26:18 -0500
Date: Wed, 23 Mar 2005 22:26:14 +1200 (NZST)
From: steve@perfectpc.co.nz
X-X-Sender: sk@steve.kieu
Reply-To: steve@perfectpc.co.nz
To: linux-kernel@vger.kernel.org
Subject: Problem report. USB MP3 Player no longer work with kernel > 2.6.8
Message-ID: <Pine.LNX.4.62.0503232217440.4187@steve.kieu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a mp3 player Digital MP3/WMA PLAYER using USB1. With kernel 2.6.9 
when plug the device ; the kernel recognize the device
dmesg show:

usb 1-1: new full speed USB device using address 3

But loading usb-storage ; it did not see the device
dmesg shows:

SCSI subsystem initialized
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.

of course nothing happend if I mount /dev/sda1 or /dev/sda etc..;

With kernel 2.6.8 or 2.4.XX it works properly. Last time I tried with 
2.6.10 and even 2.6.11, it did not work, but the error message is different.

I am willing to help to debug the problem if asked.

Kind regards,


Steve Kieu
PerfectPC Ltd. Technical Division.
Web: http://www.perfectpc.co.nz/
Ph: 04 461 7489
Mob: 021 137 0260
