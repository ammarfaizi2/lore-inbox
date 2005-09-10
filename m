Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVIJXtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVIJXtq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVIJXtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:49:46 -0400
Received: from liszt-12.ednet.co.uk ([212.20.226.36]:32206 "EHLO
	liszt-12.ednet.co.uk") by vger.kernel.org with ESMTP
	id S932391AbVIJXtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:49:45 -0400
Message-ID: <43237171.2080203@vtrl.co.uk>
Date: Sun, 11 Sep 2005 00:51:13 +0100
From: Andrew Smith <asmith@vtrl.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050721
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel performance problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first ever posting  to this list, so please excuse me if I've 
f**cked up and broken protocol.
I use an IDE LG DVD-RW drive for backup(GSA-4081B).
Back around 2.6.10 it wrote at typically 1.6-1.7x speed, but thereafter  
it dropped to  around 0.6-0.7 x.


%hdparm -I /dev/hdd

/dev/hdd:

ATAPI CD-ROM, with removable media
        Model Number:       HL-DT-ST DVDRAM GSA-4081B              
        Serial Number:      K2B3CFE4600        
        Firmware Revision:  A100   
Standards:
        Likely used CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
HW reset results:
        CBLID- below Vih
        Device num = 1


--
Andrew



