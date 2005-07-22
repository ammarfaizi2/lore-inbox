Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVGVKF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVGVKF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 06:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVGVKFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 06:05:25 -0400
Received: from mrqout2.tiscali.it ([195.130.225.12]:29830 "EHLO
	mrqout2.tiscali.it") by vger.kernel.org with ESMTP id S261559AbVGVKFX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 06:05:23 -0400
Date: Fri, 22 Jul 2005 12:05:19 +0200
Message-ID: <42D7AA0C000149CE@mail-8.mail.tiscali.sys>
In-Reply-To: <Pine.LNX.4.61.0507221133180.11709@yvahk01.tjqt.qr>
From: sampei02@tiscali.it
Subject: Re: DriveStatusError BadCRC
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem occurs in a variable time after boot.
After few hours that pc is turned on.


>-- Messaggio Originale --
>Date:	Fri, 22 Jul 2005 11:34:55 +0200 (MEST)
>From:	Jan Engelhardt <jengelh@linux01.gwdg.de>
>To:	sampei02@tiscali.it
>cc:	linux-kernel@vger.kernel.org
>Subject: Re: DriveStatusError BadCRC
>
>
>>I bought new Maxtor HD 80 GB but somthing Fedora Core 3 crashes giving
this
>>message:
>>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>>hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
>>ide: failed opcode was: unknown
>>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>>hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
>>ide: failed opcode was: unknown
>
>Does this happen on boot?
>
>Check your harddrive... smartctl -data -a /dev/hda and look for 
>199 UDMA_CRC_Error_Count    0x0008   198   193   000    Old_age   Offline
>     -
>and
>  Commands leading to the command that caused the error were:
>  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
>  -- -- -- -- -- -- -- --  ----------------  --------------------
>  c8 00 38 2f 8f 07 e4 08  43d+13:12:02.304  READ DMA
>
>
>
>Jan Engelhardt
>-- 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________________________
TISCALI ADSL 1.25 MEGA
Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Telecom
a partire da  19,95 Euro/mese.
Attivala entro il 28 luglio, il primo MESE è GRATIS! CLICCA QUI.
http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/



