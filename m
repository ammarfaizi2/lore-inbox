Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268784AbTGJCWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 22:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268789AbTGJCWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 22:22:23 -0400
Received: from rtichy.netro.cz ([213.235.180.210]:25071 "HELO 192.168.1.21")
	by vger.kernel.org with SMTP id S268784AbTGJCWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 22:22:21 -0400
Message-ID: <05d901c3468c$20f133f0$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Samuel Flory" <sflory@rackable.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "David van Hoose" <davidvh@cox.net>
Cc: <linux-kernel@vger.kernel.org>, <mru@users.sourceforge.net>
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <yw1xadbnx017.fsf@users.sourceforge.net> <02ff01c34642$5512d7f0$401a71c3@izidor> <3F0C5D55.4030304@rackable.com> <039701c34675$81a8b0e0$401a71c3@izidor> <3F0CB01F.5070308@rackable.com> <03dd01c3467a$7281a7c0$401a71c3@izidor> <3F0CB842.2050102@rackable.com>
Subject: Re: Promise SATA 150 TX2 plus
Date: Thu, 10 Jul 2003 04:36:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some new info about my problem - when there is no disk drive connected,
the drives loads cleanly. But when I connect the PATA drive (I don't have
currently
SATA disk drive free for testing) I got this message. I got clean SuSE 8.0
installed.
I will write this to promise, any idea what could be wrong? This is the
original promise
driver, now I am going to try the other driver.
Thank you for the answer
    Milan Roubal

PROMISE SATA150 Series Linux Driver v1.00.0.6
PCI: Found IRQ 10 for device 02:04.0
Drive  5 - WDC WD1000JB-32CWE0    195371567s 100030MB  UDMA5
scsi1 : pdc-ultra
scsi: unknown type 31
  Vendor: ST  0123  Model: 456789ABCDEFGHIJ  Rev: KLMN
  Type:   Unknown                            ANSI SCSI revision: 07
scsi: unknown type 31
  Vendor: ST  0123  Model: 456789ABCDEFGHIJ  Rev: KLMN
  Type:   Unknown                            ANSI SCSI revision: 07
scsi: unknown type 31
  Vendor: ST  0123  Model: 456789ABCDEFGHIJ  Rev: KLMN
  Type:   Unknown                            ANSI SCSI revision: 07
scsi: unknown type 31
  Vendor: ST  0123  Model: 456789ABCDEFGHIJ  Rev: KLMN
  Type:   Unknown                            ANSI SCSI revision: 07
  Vendor:           Model: WDC WD1000JB-32C  Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor:           Model: WDC WD1000JB-32C  Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor:           Model: WDC WD1000JB-32C  Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor:           Model: WDC WD1000JB-32C  Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 31
Attached scsi generic sg2 at scsi1, channel 0, id 1, lun 0,  type 31
Attached scsi generic sg3 at scsi1, channel 0, id 2, lun 0,  type 31
Attached scsi generic sg4 at scsi1, channel 0, id 3, lun 0,  type 31
Attached scsi disk sda at scsi1, channel 0, id 4, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 5, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 6, lun 0
Attached scsi disk sdd at scsi1, channel 0, id 7, lun 0
resize_dma_pool: unknown device type 31
resize_dma_pool: unknown device type 31
resize_dma_pool: unknown device type 31
resize_dma_pool: unknown device type 31
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
 sda:kernel BUG at <bad filename>:14979!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c6880146>]    Not tainted
EFLAGS: 00010046
eax: 0685a000   ebx: 00000018   ecx: c009e000   edx: c009e018
esi: 00000003   edi: 00000004   ebp: c685b400   esp: c69afc44
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 443, stackpage=c69af000)
Stack: c685b400 c033f000 c009e000 c31ea61c c1000020 00000004 c688296c
c1792800
       c685b400 00000293 c686dc58 c685b400 c31ea5a0 00000000 c68cf480
c1818000
       c009e000 c01b45ea c686dc00 00000001 00000002 00000800 c68cf480
c009e000
Call Trace: [<c688296c>] [<c01b45ea>] [<c01e3f7d>] [<c01e0b82>] [<c01e56e8>]
   [<c01e6f2f>] [<c01b3c88>] [<c011d02c>] [<c013aa9e>] [<c0129508>]
[<c012954c>]
   [<c012b7f6>] [<c0157fe6>] [<c013c22c>] [<c0158e2e>] [<c0159022>]
[<c014947a>]
   [<c013c5ae>] [<c0157e14>] [<c01195f3>] [<c01eb731>] [<c0157f79>]
[<c0157eb7>]
   [<c01ebdb5>] [<c688006a>] [<c01e1bdf>] [<c688a2a0>] [<c688006a>]
[<c688006a>]
   [<c01e2206>] [<c688a2a0>] [<c6882e1e>] [<c688a2a0>] [<c011a10d>]
[<c6880060>]
   [<c0108833>]

Code: 0f 0b 83 3a 00 74 13 8b 02 05 00 00 00 40 89 42 0c c7 42 10


