Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275382AbRIZRrl>; Wed, 26 Sep 2001 13:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275383AbRIZRrc>; Wed, 26 Sep 2001 13:47:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19206 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275382AbRIZRrT>; Wed, 26 Sep 2001 13:47:19 -0400
Subject: Re: Locking comment on shrink_caches()
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 26 Sep 2001 18:50:08 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        bcrl@redhat.com, marcelo@conectiva.com.br, andrea@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com> from "Linus Torvalds" at Sep 26, 2001 10:25:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mIoy-0001Hd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and for completeness

VIA Cyrix CIII (original generation 0.18u)

nothing: 28 cycles
locked add: 29 cycles
cpuid: 72 cycles

Pentium Pro

nothing: 33 cycles
locked add: 51 cycles
cpuid: 98 cycles

(base comparison - pure in order machine)

IDT winchip

nothing: 17 cycles
locked add: 20 cycles
cpuid: 33 cycles

