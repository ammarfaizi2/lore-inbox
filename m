Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbUB0RBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbUB0RBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:01:15 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:62980 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263050AbUB0RBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:01:05 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
Date: Fri, 27 Feb 2004 13:38:01 +0100
User-Agent: KMail/1.6.1
Cc: "Martin Bene" <martin.bene@icomedias.com>
References: <FA095C015271B64E99B197937712FD020B01BB@freedom.grz.icomedias.com>
In-Reply-To: <FA095C015271B64E99B197937712FD020B01BB@freedom.grz.icomedias.com>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402271338.01853@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 February 2004 13:22, Martin Bene wrote:

Hi Martin,

> When trying to update the kernel from 2.4.25 to 2.6.3 I run into a probelm:
> While the driver for the onboard Intel E1000 network adapter loads OK, it
> doesn't seem to find an interrupt for the interface - ifconfig shows:
> eth0      Link encap:Ethernet  HWaddr 00:0E:A6:2D:7A:64
>           BROADCAST MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>           Base address:0x9000 Memory:fc000000-fc020000
> [ ... ripped the rest ... ]
> Board is an Asus PC-DL, Intel 875P Chipset, one Xeon 2.8Ghz CPU, Onboard
> e1000 Network interface. Any idea how I can get the onboard NIC to work?

full output of /var/log/dmesg || dmesg after bootup might help.

ciao, Marc

