Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269723AbUINUlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269723AbUINUlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269764AbUINUka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:40:30 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:44478 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269723AbUINUjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:39:15 -0400
Subject: Re: [2.6.8.1/x86] The kernel is _always_ compiled with -msoft-float
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Denis Zaitsev <zzz@anda.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040915021418.A1621@natasha.ward.six>
References: <20040915021418.A1621@natasha.ward.six>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095190563.17043.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 20:36:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 21:14, Denis Zaitsev wrote:
> Why this kernel is always compiled with the FP emulation for x86?
> This is the line from the beginning of arch/i386/Makefile:

To catch incorrect use of FPU code in the kernel

