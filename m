Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291250AbSBLXTr>; Tue, 12 Feb 2002 18:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291268AbSBLXTV>; Tue, 12 Feb 2002 18:19:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37394 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291254AbSBLXSA>; Tue, 12 Feb 2002 18:18:00 -0500
Subject: Re: [patch] sys_sync livelock fix
To: akpm@zip.com.au (Andrew Morton)
Date: Tue, 12 Feb 2002 23:31:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3C69A18A.501BAD42@zip.com.au> from "Andrew Morton" at Feb 12, 2002 03:13:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16amOF-0003Rk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Given that /bin/sync calls write_unlocked_buffers() three times,
> that's good enough.  sync still takes aaaaaages, but it terminates.

Whats wrong with sync not terminating when there is permenantly I/O left ?
Its seems preferably to suprise data loss
