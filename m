Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUCBAg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 19:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbUCBAg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 19:36:26 -0500
Received: from [212.145.151.1] ([212.145.151.1]:21425 "EHLO oasismp.net")
	by vger.kernel.org with ESMTP id S261519AbUCBAgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 19:36:23 -0500
From: Pedro Larroy <piotr@member.fsf.org>
Reply-To: piotr@oasismp.net
Organization: larroy.com
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm1
Date: Tue, 2 Mar 2004 01:20:04 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403020120.04438.piotr@member.fsf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 typhoon: Unknown symbol direct_csum_partial_copy_generic
 kobject_register failed for aic7xxx (-17)
 Call Trace:
  [kobject_register+78/80] kobject_register+0x4e/0x50
  [bus_add_driver+68/144] bus_add_driver+0x44/0x90
  [pci_register_driver+48/64] pci_register_driver+0x30/0x40
  [__crc_sb_min_blocksize+1584399/1735921] ahc_linux_pci_init+0xd/0x20 
[aic7xxx]
  [__crc_sb_min_blocksize+1550840/1735921] ahc_linux_detect+0x46/0x90 
[aic7xxx]
  [__crc_sb_min_blocksize+1314431/1735921] ahc_linux_init+0xd/0x20 [aic7xxx]
  [sys_init_module+271/576] sys_init_module+0x10f/0x240
  [filp_close+79/128] filp_close+0x4f/0x80
  [syscall_call+7/11] syscall_call+0x7/0xb



-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     

