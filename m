Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUAHElT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 23:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUAHElT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 23:41:19 -0500
Received: from sea2-f38.sea2.hotmail.com ([207.68.165.38]:43279 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263702AbUAHElS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 23:41:18 -0500
X-Originating-IP: [81.250.248.165]
X-Originating-Email: [thadeum@hotmail.com]
From: "Silk Thadeum" <thadeum@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: /drivers/net/tulip/dmfe.c may be outdated : kernel loading problem
Date: Thu, 08 Jan 2004 05:41:17 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F38LFQG101s7hp0000e306@hotmail.com>
X-OriginalArrivalTime: 08 Jan 2004 04:41:17.0710 (UTC) FILETIME=[A7BC6AE0:01C3D5A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been working on Linux 2.4.20 for a couple of months and use a Davicom 
Semiconductor Ethernet network card driver known as dmfe.c for module dmfe.

I had no problem since here, but on Linux 2.6.0-i386-stable kernel is 
refusing to load the module :

--
$ insmod dmfe.o
insmod: error inserting 'dmfe.o': -1 Invalid module format
$ lspci | grep Davicom
00:0a.0 Ethernet controller : Davicom Semiconductor, Inc. Ethernet 100/10 
Mbit (rev 31)
--

I tried to load the module by various ways : with old (for 2.4.20) and new 
(from 2.6.0 stable) compiled driver, but that didn't work. I quickly looked 
at the source code which seems quite old. I can't actually help you in 
having a deeper workaround because I don't yet have sufficient technical 
skills for that.

I'm working on a Debian Sarge testing prerelease.

Have fun in debug ;p

Regards,

Thadeum.

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

