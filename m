Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282095AbRK1JZS>; Wed, 28 Nov 2001 04:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282081AbRK1JZH>; Wed, 28 Nov 2001 04:25:07 -0500
Received: from [193.78.30.180] ([193.78.30.180]:22610 "EHLO
	rotterdam.jasongeo.com") by vger.kernel.org with ESMTP
	id <S282093AbRK1JZB>; Wed, 28 Nov 2001 04:25:01 -0500
From: "Wouter van Bommel" <wvanbommel@jasongeo.com>
To: <linux-kernel@vger.kernel.org>
Subject: Still problems with memory allocations
Date: Wed, 28 Nov 2001 10:29:40 +0100
Message-ID: <002001c177ef$356f4be0$950000c0@jason.nl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Hoping that the problems with alloc_pages where solved I installed suse 7.3
on a SMP machine with 2 GB of memory.

This machine had some problems with the 2.4.4 kernel, constant crashes in X,
but looks stable with the new kernel 2.4.10, however I ocassionally see the
following message:

__alloc_pages: 0-order allocation failed

which is a bit strange as I know for sure that there is at least 15 MB of
unused memory on the machine when the messages appeared.
The result of the above message is that finally X crashed, but also
applications like ssh stopped working.

I hope someone can help me solve this problem. For the rest I can say that
this kernel is much more stable than the 2.4.4 I was previously running.
So keep up the good work.

- Wouter

