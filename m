Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270133AbRHRMyd>; Sat, 18 Aug 2001 08:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270134AbRHRMy0>; Sat, 18 Aug 2001 08:54:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47365 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270133AbRHRMyH>; Sat, 18 Aug 2001 08:54:07 -0400
Subject: Re: Strange Slowdown
To: ms@citd.de (Matthias Schniedermeyer)
Date: Sat, 18 Aug 2001 13:57:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0108181156140.5058-100000@citd.owl.de> from "Matthias Schniedermeyer" at Aug 18, 2001 12:02:26 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Y5ew-00014A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After i switched "High Memory-Support" to "OFF"(4GB Before) the speed went
> to normal, but now less than half RAM is used.
> Any suggestions?

This sounds like the top of memory is running uncached due to wrong mtrr
settings from the BIOS. Can you post your /proc/mtrr 
