Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282212AbRK2ARx>; Wed, 28 Nov 2001 19:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282211AbRK2ARo>; Wed, 28 Nov 2001 19:17:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46098 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280764AbRK2AR2>; Wed, 28 Nov 2001 19:17:28 -0500
Subject: Re: [PATCH] vc_tty addition
To: jsimmons@transvirtual.com (James Simmons)
Date: Thu, 29 Nov 2001 00:25:41 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        linuxconsole-dev@lists.sourceforge.net (Linux console project)
In-Reply-To: <Pine.LNX.4.10.10111281608020.4098-100000@www.transvirtual.com> from "James Simmons" at Nov 28, 2001 04:12:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169F1J-0006fw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the printk is currently writting to the VT console. This small patch is
> the first step toward that. Also tusing vc_tty will be needed in
> keyboard.c when it handles more than one keyboard.

What happens when you have no tty bound to your console - and its just for
messages (eg the printer port console) ?
