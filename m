Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283286AbRLZT4Y>; Wed, 26 Dec 2001 14:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283717AbRLZT4M>; Wed, 26 Dec 2001 14:56:12 -0500
Received: from flrtn-2-m1-236.vnnyca.adelphia.net ([24.55.67.236]:52102 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S283286AbRLZTzt>;
	Wed, 26 Dec 2001 14:55:49 -0500
Message-ID: <3C2A2B2F.1030001@pobox.com>
Date: Wed, 26 Dec 2001 11:55:27 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre1
In-Reply-To: <Pine.LNX.4.21.0112261510230.9875-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a reminder, sis woes persist -
all else seems fine at this point.

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.18pre1; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.4.18pre1/kernel/drivers/char/drm/sis.o
depmod:         sis_malloc_Ra3329ed5
depmod:         sis_free_Rced25333

Regards,

jjs

Marcelo Tosatti wrote:

>Hi, 
>
>So here it goes the first pre of 2.4.18 series: Pretty big patch with 3
>arch updates. 
>
>Nothing critical to the core, though.
>
>
>pre1:
>
>- S390 merge					(IBM)
>- SuperH merge					(SuperH team)
>- PPC merge					(Benjamin Herrenschmidt)
>- PCI DMA update				(David S. Miller)
>- radeonfb update 				(Ani Joshi)
>- aty128fb update				(Ani Joshi)
>- Add nVidia GeForce3 support to rivafb		(Ani Joshi)
>- Add PM support to opl3sa2			(Zwane Mwaikambo)
>- Basic ethtool support for 3com, starfire
>  and pcmcia net drivers			(Jeff Garzik)
>- Add MII ethtool interface			(Jeff Garzik)
>- starfire,sundance,dl2k,sis900,8139{too,cp},
>  natsemi driver updates			(Jeff Garzik)
>- ufs/minix: mark inodes as bad in case of read
>  failure					(Christoph Hellwig)
>- ReiserFS fixes				(Oleg Drokin)
>- sonypi update					(Stelian Pop)
>- n_hdlc update					(Paul Fulghum)
>- Fix compile error on aty_base.c		(Tobias Ringstrom)
>- Document cpu_to_xxxx() on kernel-hacking doc  (Rusty Russell)
>- USB update					(Greg KH)
>- Fix sysctl console loglevel bug on 
>  IA64 (and possibly other archs)		(Jesper Juhl) 
>- Update Athlon/VIA PCI quirks			(Calin A. Culianu)
>- blkmtd update					(Simon Evans)
>- boot protocol update (makes the highest 
>  possible initrd address available to the 
>  bootloader)					(H. Peter Anvin)
>- NFS fixes					(Trond Myklebust)
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


