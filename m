Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132559AbRDKLh2>; Wed, 11 Apr 2001 07:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRDKLhS>; Wed, 11 Apr 2001 07:37:18 -0400
Received: from mta04-acc.tin.it ([212.216.176.35]:41939 "EHLO fep04-svc.tin.it")
	by vger.kernel.org with ESMTP id <S132559AbRDKLhI> convert rfc822-to-8bit;
	Wed, 11 Apr 2001 07:37:08 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
From: lomarcan@tin.it
Reply-To: lomarcan@tin.it
Subject: SCSI tape corruption problem
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010411113702.GURC24736.fep04-svc.tin.it@fep41-svc.tin.it>
Date: Wed, 11 Apr 2001 13:37:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently installed a SDT-9000 tape drive. Running kernel 2.4.x I've
noticed the following (critical) problem:

Apparently the data are corrupted on the way to (from?) tape. I'm sure the
DAT 
drive is good (worked good on NT, head clean, new cartridge). It doesn't
report
data errors. I've got bad CRC errors on tar (the gzip part, of course)

The drive is on an Adaptec 2904 controller, with a Yamaha CDRW on the same
bus.
I'm pretty sure it's terminated correctly. Another SCSI controller (2940)
is 
driving 2 hard drives. Underlying HW: Athlon 1GHz, on Asus board (VIA
chipset). 
It seems to happen frequently (tried four times with about 600MB of data,
three
times failed the restore :((. Tried all the 2.4.x kernel series (thru
2.4.3)

What can it be? (I'll try to compare the read data with the original...)

				-- Lorenzo Marcantonio

