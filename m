Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSJPRZT>; Wed, 16 Oct 2002 13:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbSJPRZT>; Wed, 16 Oct 2002 13:25:19 -0400
Received: from thinkpad.c0202001.roe.itnq.net ([217.112.132.138]:9130 "EHLO
	thinkpad.c0202001.roe.itnq.net") by vger.kernel.org with ESMTP
	id <S261206AbSJPRZS>; Wed, 16 Oct 2002 13:25:18 -0400
Date: Wed, 16 Oct 2002 19:31:40 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@thinkpad.c0202001.roe.itnq.net
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] apm resume hangs on IBM T22 with 2.4.19 (harddrive sleeps
 forever)
Message-ID: <Pine.LNX.4.43.0210161930260.466-100000@thinkpad.c0202001.roe.itnq.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a similar problem with a ALi M5229 but only with dma enabled. if
> it suspends with dma enabled, when it resumes I got dma timeouts until
> it give up and disable dma. after this I can't enable dma anymore. I
> guess implementing resume() of alim15x3 to reconfigure chipset will
> solve this. any sugestions/comments?

Yep! That's right! When I disabled DMA on hd, two 'broken' kernels were
able to wake up it - 2.4.19pre4 and 2.4.20pre10. So IMHO problem is
solved. I'm just curious what changed in 2.4.19pre3-4 that it caused this
problem and at the second I have classical i440BX + PIIX4 ide.

Anyway, thanks a lot,

Cheers,

Karel
--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com


