Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbRGKP5N>; Wed, 11 Jul 2001 11:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267341AbRGKP5B>; Wed, 11 Jul 2001 11:57:01 -0400
Received: from usr450-gh1.blueyonder.co.uk ([62.31.167.204]:39172 "EHLO
	tim.rpnet.com") by vger.kernel.org with ESMTP id <S267339AbRGKP4i>;
	Wed, 11 Jul 2001 11:56:38 -0400
Message-ID: <009201c10a21$fb9614c0$0301a8c0@rpnet.com>
From: "Richard Purdie" <rpurdie@bigfoot.com>
To: <john@unidec.co.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <007501c10a1b$bc3a0bc0$0301a8c0@rpnet.com> <01071116375404.29517@frumious.unidec.co.uk>
Subject: Re: PROBLEM: <BUG Report: kernel BUG at slab.c:1062! from pppd with speedtouch drivers and pppoatm>
Date: Wed, 11 Jul 2001 16:55:59 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just to check: I got exactly the same thing, and a very similar oops (EIP
> in kmem_cache_grow &c) when trying to load sb.o & opl3.o under 
> 2.4.7-pre5. It was caused by the fact that I hadn't updated 
> /etc/modules.conf to point to the correct directory, and the kernel was
> trying to load modules from 2.4.5.
> Can you check to make sure that the modules being loaded are the correct
> ones for the kernel version?

I'm quite certain that it's loading modules from /lib/modules/2.4.6
(confirmed with modprobe -c). My /etc/modules.conf file doesn't have any
paths in it.

Cheers,

RP


