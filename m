Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbRIJJKQ>; Mon, 10 Sep 2001 05:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268837AbRIJJKH>; Mon, 10 Sep 2001 05:10:07 -0400
Received: from wet.kiss.uni-lj.si ([193.2.98.10]:62217 "EHLO
	wet.kiss.uni-lj.si") by vger.kernel.org with ESMTP
	id <S268714AbRIJJKC>; Mon, 10 Sep 2001 05:10:02 -0400
Content-Type: text/plain;
  charset="iso-8859-2"
From: Rok =?iso-8859-2?q?Pape=BE?= <rok.papez@kiss.uni-lj.si>
Reply-To: rok.papez@kiss.uni-lj.si
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9: PDC20267 not working
Date: Mon, 10 Sep 2001 10:32:18 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B9C16AF.8F1599E6@tconl.com>
In-Reply-To: <3B9C16AF.8F1599E6@tconl.com>
Cc: Joe Fago <cfago@tconl.com>
MIME-Version: 1.0
Message-Id: <01091010321800.01030@strader.home>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Monday 10 September 2001 03:26, Joe Fago wrote:

> PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode
>   ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda: pio, hdb: pio
>   ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc: pio, hdd: DMA
> hda: Maxtor 2B020H1, ATA DISK drive
>
>
> This is the only device attached to the controller. Any suggestions?

ASUS A7V with on-board PDC20265, kernel 2.4.9 with ACPI support - it hangs on 
detection of the last drive (hde). I've disabled APM and ACPI altogether in 
the kernel and now it works.
I didn't play with edge/level setting of interrupts.

-- 
best regards,
Rok Pape¾.
