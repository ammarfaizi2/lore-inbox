Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUBEFEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 00:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUBEFEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 00:04:08 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:59000 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264257AbUBEFEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 00:04:07 -0500
Message-ID: <4021CEDF.3030705@myrealbox.com>
Date: Thu, 05 Feb 2004 10:34:31 +0530
From: romit dasgupta <romit@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OT] DMA access from a non-bus master PCI device?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
            I have a PCI device that cannot be a PCI bus master (only a 
PCI target). For some reason it has a DMA controller. Since it can't be 
a bus master I can't initiate DMA transfers from this PCI device to 
system RAM.
My question is, can we use the motherboard's DMA controller to perform 
this transfer? In some of the documents that I got in the web 
(http://www.pcguide.com/ref/mbsys/res/dma/func.htm), it is mentioned 
that the 8237 DMA controller that comes with standard motherboard 
chipsets, can only be used for DMA transfers over the ISA bus.
Any comments are welcome.

Regards,
-Romit

