Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSDSKW7>; Fri, 19 Apr 2002 06:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312326AbSDSKW6>; Fri, 19 Apr 2002 06:22:58 -0400
Received: from zamok.crans.org ([138.231.136.6]:35467 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S312254AbSDSKWx>;
	Fri, 19 Apr 2002 06:22:53 -0400
To: Andy Jeffries <lkml@andyjeffries.co.uk>
Cc: "Vasja J Zupan" <vasja@nuedi.com>, linux-kernel@vger.kernel.org
Subject: Re: HPT372 on KR7A-133R (ATA133) on production server
In-Reply-To: <001d01c1e6e3$c2ef1e60$b4a6a8c0@si>
	<20020418161217.5bcccbb2.lkml@andyjeffries.co.uk>
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
From: Vincent Bernat <bernat@free.fr>
Organization: Kabale Inc
Date: Fri, 19 Apr 2002 12:22:50 +0200
Message-ID: <m3u1q8yolh.fsf@neo.loria>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OoO Lors de la soirée naissante du jeudi 18 avril 2002, vers 17:12,
Andy Jeffries <lkml@andyjeffries.co.uk> disait:

> It was crashing the Kernel, I helped a friend get his working with a patch
> which he has uploaded on his website.  To date, I haven't had a reply when
> I tried to ask who to submit it to on here (2.4.18 isn't fixed
> AFAIK).

I was experiencing DMA trouble with 2.4.18 when using software RAID 0
on this motherboard. There was no problem when not using RAID
software, even when doing parallel transfer between two disks. The
problem disappeared with Alan Cox' 2.4.19-pre4-ac6 (not sure, will
check the version, but the problem still was here with
2.4.19-pre2-ac4).

There was no problem when using software RAID for the card (but
performances were poor). But definitly, it is still under heavy
development.
-- 
 /*
  * Hash table gook..
  */
	2.4.0-test2 /usr/src/linux/fs/buffer.c
