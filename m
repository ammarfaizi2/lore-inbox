Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288473AbSANAiU>; Sun, 13 Jan 2002 19:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288449AbSANAgo>; Sun, 13 Jan 2002 19:36:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3085 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288473AbSANAgG>; Sun, 13 Jan 2002 19:36:06 -0500
Subject: Re: Linux 2.4.18pre3-ac1
To: akropel1@rochester.rr.com (Adam Kropelin)
Date: Mon, 14 Jan 2002 00:47:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <028b01c19c90$87300760$02c8a8c0@kroptech.com> from "Adam Kropelin" at Jan 13, 2002 07:15:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PvI2-0008WI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in the "Writeout in recent kernels..." thread) on this release. Performance and
> observed writeout behavior was essentially the same as for 2.4.17, both stock
> and with -rmap11a. Transfer time was 6:56 and writeout was uneven. 2.4.13-ac7 is
> still the winner by a significant margin.

That is very useful information actually. That does rather imply that some
of the performance hit came from the block I/O elevator differences in the
old ac tree (the ones Linus hated ;)). Now the question (and part of the
reason Linus didnt like them) - is why ?

Alan
