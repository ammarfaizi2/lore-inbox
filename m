Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754496AbWKHJzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbWKHJzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbWKHJzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:55:39 -0500
Received: from kilderkin.sout.netline.net.uk ([213.40.66.40]:22264 "EHLO
	kilderkin.sout.netline.net.uk") by vger.kernel.org with ESMTP
	id S1754498AbWKHJzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:55:17 -0500
Message-ID: <4551A981.60709@supanet.com>
Date: Wed, 08 Nov 2006 09:55:13 +0000
From: Andrew Benton <b3nt@supanet.com>
User-Agent: Thunderbird 3.0a1 (X11/20061019)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Typo in drivers/usb/input/wacom_wac.c?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Supanet-AV-out: Mail Scanned as virus free, although you should still use a local virus scanner.
X-Supanet: This was sent via a www.supanet.com mail server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello World,
my Wacom Volito2 tablet doesn't work with the kernel driver as it is. 
The cursor jitters about at the bottom of the screen in a useless 
manner. However, if I edit drivers/usb/input/wacom_wac.c and change the 
two instances of wacom_be16_to_cpu to wacom_le16_to_cpu then it works 
perfectly

sed -i 's/_b/_l/' drivers/usb/input/wacom_wac.c

Andy
