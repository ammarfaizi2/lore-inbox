Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269179AbRHFXoF>; Mon, 6 Aug 2001 19:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269183AbRHFXn4>; Mon, 6 Aug 2001 19:43:56 -0400
Received: from adsl-64-171-26-48.dsl.sntc01.pacbell.net ([64.171.26.48]:4932
	"HELO top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S269179AbRHFXnh>; Mon, 6 Aug 2001 19:43:37 -0400
From: brian@worldcontrol.com
Date: Mon, 6 Aug 2001 16:43:33 -0700
To: linux-kernel@vger.kernel.org
Subject: eth0: Error -16 writing packet header to BAP
Message-ID: <20010806164333.A4154@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Never seen this error before:

Aug  6 16:40:13 top kernel: eth0: Error -16 writing packet header to BAP 
Aug  6 16:40:13 top last message repeated 403 times

eth0 is:

Aug  6 16:40:25 top cardmgr[535]: executing: 'modprobe orinoco'
Aug  6 16:40:25 top kernel: orinoco.c 0.06c (David Gibson <hermes@gibson.dropbear.id.au> and others) 
Aug  6 16:40:25 top cardmgr[535]: executing: 'modprobe orinoco_cs'
Aug  6 16:40:25 top kernel: dldwd: David's Less Dodgy WaveLAN/IEEE Driver 
Aug  6 16:40:25 top kernel: orinoco_cs.c 0.06 (David Gibson <hermes@gibson.dropbear.id.au> and others) 
Aug  6 16:40:25 top kernel: eth0: Firmware ID 1F vendor 0x1 (Lucent) version 6.04 
Aug  6 16:40:25 top kernel: eth0: Ad-hoc demo mode supported. 
Aug  6 16:40:25 top kernel: eth0: WEP supported, "128"-bit key. 
Aug  6 16:40:25 top kernel: eth0: MAC address 00:E0:63:82:45:DA 
Aug  6 16:40:25 top kernel: eth0: Station name "HERMES I" 
Aug  6 16:40:25 top kernel: eth0: ready 

Linux is: 2.4.7-ac7

Previously I've was running 2.4.7ac3.

Pulled the card and reinserted and all is well.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
