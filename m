Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266360AbUFZTFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266360AbUFZTFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 15:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266380AbUFZTFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 15:05:15 -0400
Received: from mxsf24.cluster1.charter.net ([209.225.28.224]:26373 "EHLO
	mxsf24.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S266360AbUFZTFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 15:05:08 -0400
Message-ID: <40DDC641.1070403@hbahr.org>
Date: Sat, 26 Jun 2004 13:53:53 -0500
From: hab <hab@hbahr.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sata-Sil bk6-bk8 hangs Maxtor with S-P bridge
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With Bk6 and beyond I recieve a
command 0x25 Timeout Stat 0x50 host-stat 0x4  and then a hang in init.
I can cntl alt del to reboot.
This is with a Maxtor 6y160po  YAR4,  I also have a Maxtor 6y250P0

Earlier in the boot sequence I recieve a screaming interupt message and
interupt turned off message for the interupt used by the controller.

These work for 2.6.7 and 2.6.7 bk5.
It works for the ide implementation with the thousands of

sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq

messages.

thanks  Hubert
