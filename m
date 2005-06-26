Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVFZEg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVFZEg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 00:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVFZEg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 00:36:26 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:56498 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S261521AbVFZEgV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 00:36:21 -0400
Mime-Version: 1.0
Message-Id: <a06230916bee3de9dd698@[129.98.90.227]>
Date: Sun, 26 Jun 2005 00:37:08 -0400
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: [Q] What is the significance of the "Out of IOMMU Space" error?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.12 on AMD Opteron on an Arima HDAMA board with a 3ware 
8506 card installed and got the following in the log:

Jun 25 15:56:34 [kernel] [53161.700276] PCI-DMA: Out of IOMMU space 
for 65536 bytes at device 0000:03:01.0
Jun 25 15:56:34 [kernel] [53161.700279] 3w-xxxx: 
tw_map_scsi_sg_data(): pci_map_sg() failed.
Jun 25 15:56:34 [kernel] [53161.700332] SCSI error : <0 0 0 0> return 
code = 0x70000
Jun 25 15:56:34 [kernel] [53161.700334] end_request: I/O error, dev 
sda, sector 51296795


This error doesn't seem to be mentioned much in this space. Should it 
be taken at face value? Is it something simple like IOMMU should be 
set to a higher value in the HDAMA bios? A kernel bug? Or could it 
actually be bad physical memory or even a bad card?

Does it mean the data integrity on the affected hard drive is compromised?
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
