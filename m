Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268685AbUHTTDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbUHTTDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268677AbUHTTCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:02:53 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:6626 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S268682AbUHTTBC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:01:02 -0400
Message-ID: <41264A3B.7050802@ttnet.net.tr>
Date: Fri, 20 Aug 2004 22:00:11 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: bjorn.helgaas@hp.com
Subject: Re: Fw: 2.6.8.1-mm2: floppy magically disappaperd
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn:

I also had the same problem as the original poster.
Your new patch fixed my case. Here's the excerpt
from my dmesg:

inserting floppy driver for 2.6.8.1-mm2
acpi_floppy_resource: 4 ioports at 0x3f2
acpi_floppy_resource: 1 ioports at 0x3f7
floppy: controller ACPI FDC0 at I/O 0x3f2-0x3f5, 0x3f7-0x3f7 irq 6 dma 
channel 2Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077

Regards,
Ozkan Sezer
