Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279519AbRJXKCr>; Wed, 24 Oct 2001 06:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279509AbRJXKC2>; Wed, 24 Oct 2001 06:02:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18693 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279503AbRJXKCT>; Wed, 24 Oct 2001 06:02:19 -0400
Subject: Re: A small pile of locking bugs
To: jfoster@cs.berkeley.edu (Jeff Foster)
Date: Wed, 24 Oct 2001 11:08:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, tachio@EECS.Berkeley.EDU
In-Reply-To: <Pine.LNX.4.33.0110231359530.8770-100000@lagaffe.cs.berkeley.edu> from "Jeff Foster" at Oct 23, 2001 03:08:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wKxm-00015Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/i2o/i2o_proc.c
>         In i2o_proc_read_drivers_stored, spinlock not released when
> 	kmalloc fails.  Also, calling kmalloc with a lock is dangerous.

Correct, and fixed.
