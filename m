Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVCNQNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVCNQNj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVCNQNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:13:39 -0500
Received: from [193.112.238.6] ([193.112.238.6]:58011 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S261555AbVCNQNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:13:37 -0500
Subject: Hangup using USB Flash "Disks"
From: John M Collins <jmc@xisl.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Xi Software Ltd
Date: Mon, 14 Mar 2005 16:13:35 +0000
Message-Id: <1110816815.22174.25.camel@caveman.xisl.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me at jmc@xisl.com as I'm not subscribed.

I'm using kernel 2.6.8.1 (from Mandrake 10.1 I usually like to build a
custom kernel for each machine we've got).

I've recently taken to using USB Flash "Disks" to carry stuff around on
and I've not had any problems except on one machine.with exclusively
SCSI disks (apart from the DVD writer).

I don't have any problem mounting the disks but when I want to remove
them the USB support seems to get itself into a knot - I can unmount
them OK but when I physically detach them the USB stuff gets itself
entangled waiting for an interrupt that never happens - I get "Immortal"
processes - if I do

cat /proc/bus/usb/devices

or anything such as usbview which does the same thing the process
becomes "immortal" and a creeping paralysis seems to come over the
system so I have to reboot - and of course with so many directories
being open everything has to be fsck-ed.

I have the same kernel and general setup on 4 other machines with only
IDE disks and have no problem plugging and unplugging flash disks.

Could anyone advise what I can do? I'll be pleased to send configuration
info or provide login information so you can poke around yourselves.

-- 

John Collins Xi Software Ltd www.xisl.com Tel: +44 (0)1707 886110
(Direct) +44 (0)7799 113162 (Mobile)

