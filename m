Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262949AbTCSIHg>; Wed, 19 Mar 2003 03:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262955AbTCSIHg>; Wed, 19 Mar 2003 03:07:36 -0500
Received: from tag.witbe.net ([81.88.96.48]:14089 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S262949AbTCSIHH>;
	Wed, 19 Mar 2003 03:07:07 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Juha Poutiainen'" <pode@iki.fi>, <linux-kernel@vger.kernel.org>
Subject: Re: L2 cache detection in Celeron 2GHz (P4 based)
Date: Wed, 19 Mar 2003 09:18:04 +0100
Message-ID: <00b801c2edf0$105d7750$6100a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20030319064743.GA1683@a28a>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Kernel doesn't seem to detect L2 cache in 2GHz Pentium4 based 
> Celeron. 
> Most likely it is working normally (BIOS detects it and no 
> system speed 
> is ok), but it's not shown in dmesg or /proc/cpuinfo.

Got the same problem...
You can also add that the L1 detection doesn't seem to be correct
either : 
0K Instruction cache, and 8K data cache for L1... This is not much
for instruction, it seems it should be 12K...

Regards,
Paul

