Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264731AbSKEHTg>; Tue, 5 Nov 2002 02:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264768AbSKEHTg>; Tue, 5 Nov 2002 02:19:36 -0500
Received: from [211.150.96.25] ([211.150.96.25]:30374 "EHLO smtp.x263.net")
	by vger.kernel.org with ESMTP id <S264731AbSKEHTg>;
	Tue, 5 Nov 2002 02:19:36 -0500
From: "kcn" <kcn@263.net>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel freeze
Date: Tue, 5 Nov 2002 15:25:42 +0800
Message-ID: <002d01c2849c$927faa40$31036fa6@zhoulin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3842257604.1036450149@[10.10.2.3]>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll lay you a large bet that lowmem is full of garbage.
> Probably buffer_heads, inodes or PTEs. Output of /proc/meminfo 
> and /proc/slabinfo as you approach oblivion would be useful.
> As would a description of the workload that triggers it.
>
> M.
  I think it's the reason. But I have to decreased memory from 4G to 2G
because of the complain from my customers, so I can't give you the
/proc/meminfo or /proc/slabinfo now. :(
  Why the linux-vm can't manage lowmem correctly? I have seen some
articles talking about the LRU pre zone patch, but why 2.4.19+rmap14a
patch also has this problem?


