Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277119AbRJUXVa>; Sun, 21 Oct 2001 19:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277161AbRJUXVV>; Sun, 21 Oct 2001 19:21:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47364 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277119AbRJUXVD>; Sun, 21 Oct 2001 19:21:03 -0400
Subject: Re: /proc/sys/kernel/tainted does not seem to work as intended
To: juhl@eisenstein.dk (Jesper Juhl)
Date: Mon, 22 Oct 2001 00:28:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BD356BB.8FB3700D@eisenstein.dk> from "Jesper Juhl" at Oct 22, 2001 01:14:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vS0f-0008Ks-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> with X) and the nVidia drivers load as X is started, I check
> /proc/sys/kernel/tainted and find that it is still 0. Since the nVidia
> drivers are binary only and not GPL shouldn't /proc/sys/kernel/tainted
> be 1 (or at least != 0) ???

It depends if your modutils are current - the work is done in the modutils
not the kernel
