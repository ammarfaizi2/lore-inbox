Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130993AbRCFQIL>; Tue, 6 Mar 2001 11:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131002AbRCFQIB>; Tue, 6 Mar 2001 11:08:01 -0500
Received: from b1.ovh.net ([213.186.33.51]:16367 "HELO ns0.ovh.net")
	by vger.kernel.org with SMTP id <S130993AbRCFQHr>;
	Tue, 6 Mar 2001 11:07:47 -0500
From: "Stephane GARIN" <sgarin@sgarin.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.2.19pre - Kernel Panic: no init found
Date: Tue, 6 Mar 2001 17:06:06 +0100
Message-ID: <000e01c0a657$5a359340$4601a8c0@oracle.intranet>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200103031758.f23HwQn02197@stev.org>
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried with init=/bin/sh but no success. I download a 2.2.18 Kernel and I
use patch 2.2.19pre16 but no success too... I don't know why there is this
error with this 2.2.19 kernel but not with my 2.2.18 kernel. I'm ready to
send all technical information about my computer (PIII 650 with 256Mb and a
ABIT BX133-RAID mothercard).

With Regards,
Stephane Garin

-----Message d'origine-----
De : James Stevenson
Envoyé : samedi 3 mars 2001 18:58
À : sgarin@sgarin.com
Objet : Re: 2.2.19pre - Kernel Panic: no init found


Hi

it would mean pass something like
init=/bin/sh
not the runlevel you want

In local.linux-kernel-list, you wrote:
>Hi,
>
>I have a kernel panic with the patch 2.2.19pre16 that I test. I use a
2.2.18
>Kernel very well. I used the last patch on this kernel and make my kernel
>with sames parameters without error message. At the boot, I can see this :
>
>..
>eth0: RealTek RTL8139 Fast Ethernet at 0xa800, IRQ 10, 00:50:fc:0b:60:70
>eth1: RealTek RTL8139 Fast Ethernet at 0xac00, IRQ 11, 00:50:fc:1f:c1:98
>Partition check:
> hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
>Trying to vfree() noexistent vm area (c00f0000)
>VFS: Mounted root (ext2 filesystem) readonly.
>Freeing unused kernel memory: 68k freed
>Kernel panic: No init found. Try passing init= option to kernel.
>
>
>
>I tried to start with init=3 but no change. I send this information on this
>mailing list because I think that could be a bug. Sorry if it is a wrong
>action of me...
>
>With Regards,
>Stephane Garin
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


--
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  5:50pm  up 4 days,  5:56,  3 users,  load average: 0.24, 0.38, 0.47

