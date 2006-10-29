Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWJ2KgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWJ2KgW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 05:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWJ2KgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 05:36:22 -0500
Received: from sitemail2.everyone.net ([216.200.145.36]:60288 "EHLO
	omta14.mta.everyone.net") by vger.kernel.org with ESMTP
	id S932168AbWJ2KgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 05:36:22 -0500
X-Eon-Dm: pop15
X-Eon-Sig: AQK/0KdFRIQls5zXAgIAAAAB,45d3ab7e99064b93513e997e05028850
Message-ID: <4544840E.8060808@buckeye-express.com>
Date: Sun, 29 Oct 2006 05:35:58 -0500
From: Jason Pool <believe@buckeye-express.com>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Bug causing problems with USB KVM switch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems with my IOgear USB KVM switch.  I am running on a 
Athlon XP with an Abit NF7 nForce2 motherboard.  Using Kubuntu 6.10 with 
stock kernel 2.6.18.1 and Ubuntu kernel 2.6.17-10-generic with the KVM 
plugged in, I get this in /var/log/messages every few seconds:

Oct 29 02:53:28 zanzibar kernel: [  105.489309] usb 1-1.1: reset low 
speed USB device using ohci_hcd and address 7

This c auses my USB keyboard to temporarily become unresponsive, and 
also makes the last key typed when being reset stick leading to 
"tyinnnnng lkeee thssssssss".  The problem goes away with the keyboard 
plugged directly into the machine without the KVM, and my USB mouse 
seems unaffected either way.

I tried installing Fedora Core 6, and the installer and installation 
gave me the same trouble, as well as the gparted 0.3.1 boot cd.  This 
has only been a problem recently, Ubuntu 6.06 gave me no problems (a 
version of 2.6.15), so I reverted to a Debian 2.6.16 kernel to see how 
that went, and it works fine.

Some change in 2.6.17 (or possibly later in 2.6.16) seems to have 
started this problem for me.

Any help would be appreciated.  I've tried to leave the relevant 
information, but as its late(early?) and I'm about to zonk out, I may 
have forgotten something.  I'd be more than happy to provide any 
additional information if needed.


