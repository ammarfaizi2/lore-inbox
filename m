Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319071AbSH2CYG>; Wed, 28 Aug 2002 22:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319072AbSH2CYG>; Wed, 28 Aug 2002 22:24:06 -0400
Received: from kraid.nerim.net ([62.4.16.95]:37391 "HELO kraid.nerim.net")
	by vger.kernel.org with SMTP id <S319071AbSH2CYF>;
	Wed, 28 Aug 2002 22:24:05 -0400
Message-ID: <3D6D5674.9090103@inet6.fr>
Date: Thu, 29 Aug 2002 01:02:12 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: 0@pervalidus.net
Subject: Re: ECS K7S5A: IDE performance
References: <Pine.LNX.4.44.0208281611210.213-100000@pervalidus.dyndns.org> <3D6D2537.F410B52A@nortelnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

>Frédéric L. W. Meunier wrote:
>
>>I just thought it'd be much more with an ATA100. I got more or
>>less the same with my earlier motherboard, an ASUS A7APro, and
>>without ATA66 - which would print a lot of CRC errors at boot
>>time if enabled in the BIOS. The K7S5A doesn't print any and is
>>rock solid.
>>
>
>If you're reading more than the size of your on-drive buffer then you'll be limited by the speed at
>which the information can be grabbed off the drive--in your case, 38.1MB/s, which is quite good.
>
>ATA33/66/100/133 only makes a significant difference in speed when you're reading from the on-drive
>cache.
>

In fact I remember having seen something like 10-20% throughput increase 
for the same drive used in UDMA mode 4 (66MB/s) on an HPT366 and UDMA 
mode 5 (100MB/s) on a SiS735 for a drive which maxed out at around 
30/35MB/s.

This could be either caused by IDE controller/PCI interface 
(mis)behaviour, drive firmware tuned for ATA100 instead of ATA66, IDE 
bus overheads. I don't know for sure, but apparently switching from 
ATA66 to ATA100 can bring some juice in some cases where the max platter 
throughput is not even near max advertised IDE bandwidth.

Anyway, to answer to the original post, 38.1 MB/s is quite good.

LB.

