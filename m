Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268413AbTBSDBD>; Tue, 18 Feb 2003 22:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268421AbTBSDBB>; Tue, 18 Feb 2003 22:01:01 -0500
Received: from f156.pav2.hotmail.com ([64.4.37.156]:64775 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S268413AbTBSDA0>;
	Tue, 18 Feb 2003 22:00:26 -0500
X-Originating-IP: [129.219.25.77]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: What does pci_map_single do
Date: Wed, 19 Feb 2003 03:10:23 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F156VoTsP4rQLlRe7by0003d952@hotmail.com>
X-OriginalArrivalTime: 19 Feb 2003 03:10:23.0422 (UTC) FILETIME=[714CDDE0:01C2D7C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I wanted to use DMA in my device driver.

1. pci_map_single will transfer the data from RAM (kernel area) to the 
hardware accessible area and will provide with a pointer which can then be 
passed to the hardware.
2. In the above function the "size" parameter indicates the amount of DMA 
transfer.
Am I correct in the above two points? If I am wrong please correct me.

In the Linux Device driver book (page 408), he says, data must be explicitly 
flushed from the processor cache. And data flushed this way is not avaliable 
to the device.

This means that we must flush the processor cache before calling 
pci_map_single. How can we achieve this.

Thanking You
Shesha



_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE* 
http://join.msn.com/?page=features/junkmail

