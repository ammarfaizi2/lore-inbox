Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280674AbRK1Ujb>; Wed, 28 Nov 2001 15:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280628AbRK1UjW>; Wed, 28 Nov 2001 15:39:22 -0500
Received: from mailrelay.netcologne.de ([194.8.194.96]:63130 "EHLO
	mailrelay.netcologne.de") by vger.kernel.org with ESMTP
	id <S280674AbRK1UjN>; Wed, 28 Nov 2001 15:39:13 -0500
Message-ID: <003101c1784c$a19aaa00$25aefea9@ecce>
From: "[MOc]cda*mirabilos" <mirabilos@netcologne.de>
To: "Padraig Brady" <padraig@antefacto.com>, "Christoph Rohland" <cr@sap.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <m3y9kqon6w.fsf@linux.local> <3C051F2D.2030804@antefacto.com> <m3u1veokyd.fsf@linux.local> <3C05238C.5080903@antefacto.com>
Subject: Re: [RFC] Documentation/filesystems/tmpfs
Date: Wed, 28 Nov 2001 20:38:25 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>In contrast to RAM disks, which get allocated a fixed amount of
> >>>physical RAM, tmpfs grows and shrinks to accommodate the files it
> >>>contains and is able to swap unneeded pages out to swap space.
> >>That isn't the case now since ramdisks were integrated with the
> >>buffer cache:
> > What isn't the case any more?
> Because the RAM is now (de)allocated as required.
> Filesystem? ext2 on /dev/ram1(rd.o)
> meminfo shows the memory being reclaimed as the file is deleted.

And this is transparent to {any|the ext2fs} underlying filesystem?
What if I use xfs, rasierfs, ntfs, $* ?

-mirabilos
-- 
Redistribution of this message body via AOL or the
Microsoft network strictly prohibited.
Quotation permitted if due credit is given.
(Excuse the X-Mailer, accusate my ISP for that)


