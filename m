Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbRL1BT0>; Thu, 27 Dec 2001 20:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285591AbRL1BTL>; Thu, 27 Dec 2001 20:19:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19463 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285589AbRL1BTD>; Thu, 27 Dec 2001 20:19:03 -0500
Subject: Re: ISA core vs. ISA card support
To: esr@thyrsus.com
Date: Fri, 28 Dec 2001 01:29:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20011227200238.B26889@thyrsus.com> from "Eric S. Raymond" at Dec 27, 2001 08:02:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Jlq0-0007bm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks, that's helpful.  I'll introduce an ISA_SLOTS private symbol, then.
> Later perhaps we can actually make this distinction in C code;  sounds
> like it would be a good idea.

There is no value to it in the kernel. ISA bus and magic that looks like
ISA bus but is welded to the motherboard look the same anyway
