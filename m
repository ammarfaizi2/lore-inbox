Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSDMSYN>; Sat, 13 Apr 2002 14:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293187AbSDMSYM>; Sat, 13 Apr 2002 14:24:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42246 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293132AbSDMSYM>; Sat, 13 Apr 2002 14:24:12 -0400
Subject: Re: Multiple zlib.c's in 2.4.18
To: Sverker.Wiberg@uab.ericsson.se (Sverker Wiberg)
Date: Sat, 13 Apr 2002 19:42:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3CB6F332.18225BA4@uab.ericsson.se> from "Sverker Wiberg" at Apr 12, 2002 04:46:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16wSTJ-0000qU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Further checking reveals that ./arch/ppc/boot/lib/zlib.c is based on
> zlib-0.95, while the other two are zlib-1.0.4.
> 
> Which one should I use? Shouldn't they be merged? And what about the
> double-free() bug?

There is progress going on to merge them (see 2.4.19-ac) so hopefully RSN
that question won't be worth asking. 
