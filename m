Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270619AbRJYMDQ>; Thu, 25 Oct 2001 08:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272773AbRJYMDF>; Thu, 25 Oct 2001 08:03:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24335 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271667AbRJYMCs>; Thu, 25 Oct 2001 08:02:48 -0400
Subject: Re: dvd and filesystem errors under 2.4.13
To: imaginos@imaginos.net (Jim Hull)
Date: Thu, 25 Oct 2001 13:09:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110250138380.1704-100000@rosebud> from "Jim Hull" at Oct 25, 2001 01:49:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wjKP-0004fk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oct 25 01:25:58 rosebud kernel: EXT2-fs error (device sd(8,1)):
> ext2_free_blocks: bit already cleared for block 133384
> Oct 25 01:25:58 rosebud kernel: EXT2-fs error (device sd(8,1)):
> ext2_free_blocks: bit already cleared for block 133385

Thats indicating memory on on disk corruption. It is something you should
be concerned about.  What version of aic7xxx is on the kernel that is
stable ?
