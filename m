Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277512AbRJJWyW>; Wed, 10 Oct 2001 18:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRJJWyC>; Wed, 10 Oct 2001 18:54:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47885 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277512AbRJJWxw>; Wed, 10 Oct 2001 18:53:52 -0400
Subject: Re: 2.4.11 oops
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 10 Oct 2001 23:59:49 +0100 (BST)
Cc: bmatthews@redhat.com (Bob Matthews), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110101540080.2918-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 10, 2001 03:44:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15rSKL-000178-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Th ebug is in get_pgd_slow() in include/asm-i386/pgalloc.h, where it just
> does a "kmalloc()" and expects the thing to be magically aligned.
> 
> Does anybody have (tested) patches for this?

Ingo did patches for -ac a long time back. I've not submitted them since
it simply didnt seem an important matter when prioritising patches,

If you want them I can isolate them tomorrow
