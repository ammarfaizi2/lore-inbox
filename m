Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTE0Tbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTE0Ta1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:30:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52127 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264094AbTE0TaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:30:01 -0400
Date: Tue, 27 May 2003 16:41:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.21-rc5
Message-ID: <Pine.LNX.4.55L.0305271640320.9487@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Mainly due to a IDE DMA problem which would happen on boxes with lots of
RAM, here is -rc5.

As I always ask, please test.


Summary of changes from v2.4.21-rc4 to v2.4.21-rc5
============================================

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o 1: (trivial) Fix the formatting of your ide hack
  o 2: =scsi option fails in some cases
  o 3: IDE DMA
  o add the via ide ident
  o fix the siimage mmio stuff

Andi Kleen <ak@muc.de>:
  o Fix 32bit ioctl holes
  o Fix context switch bug on x86-64
  o Prefetch workaround for csum-copy

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC Documentation/Configure.help fix

Marcelo Tosatti <marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to -rc5

