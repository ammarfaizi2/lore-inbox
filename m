Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSD3X06>; Tue, 30 Apr 2002 19:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSD3X05>; Tue, 30 Apr 2002 19:26:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10761 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315266AbSD3X04>; Tue, 30 Apr 2002 19:26:56 -0400
Subject: Re: SMP race condition on startup with patch
To: barrow_dj@yahoo.com (D.J. Barrow)
Date: Wed, 1 May 2002 00:45:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20020430115510.26880.qmail@web10404.mail.yahoo.com> from "D.J. Barrow" at Apr 30, 2002 04:55:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E172hJj-0000hm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I found a smp race condition on startup
> of the 2.4.18 kernel when I put a printk
> in schedule.

Yep. Its already fixed in my tree if I remember rightly. 

BTW - a useful tip for checking your port is to memset the __init pages
to an illegal instruction value as you reclaim them.
