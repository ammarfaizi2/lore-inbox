Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129062AbQJ3SVZ>; Mon, 30 Oct 2000 13:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129042AbQJ3SVP>; Mon, 30 Oct 2000 13:21:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8011 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129090AbQJ3SU6>; Mon, 30 Oct 2000 13:20:58 -0500
Subject: Re: kmalloc() allocation.
To: root@chaos.analogic.com
Date: Mon, 30 Oct 2000 18:22:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <Pine.LNX.3.95.1001030104956.735A-100000@chaos.analogic.com> from "Richard B. Johnson" at Oct 30, 2000 10:57:32 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qJZL-00076K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How much memory would it be reasonable for kmalloc() to be able
> to allocate to a module?

64K probably less. kmalloc allocates physically linear spaces. vmalloc will
happily grab you 2Mb of space but it will not be physically linear

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
