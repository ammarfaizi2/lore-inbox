Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272033AbRHVPgx>; Wed, 22 Aug 2001 11:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272034AbRHVPgc>; Wed, 22 Aug 2001 11:36:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1294 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272033AbRHVPga>; Wed, 22 Aug 2001 11:36:30 -0400
Subject: Re: Qlogic/FC firmware
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Wed, 22 Aug 2001 16:39:38 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0108220951530.6389-100000@sweetums.bluetronic.net> from "Ricky Beam" at Aug 22, 2001 10:44:14 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Za6U-0001ht-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm missing the "in the case of sparc" clause.  The sparc (and maybe others?)
> have to keep the firmware image in memory in the case that it needs to reload

Read the source code. The driver never reloads the firmware on a running
card. So if the sparc needed that it never worked anyway, and I don't follow
your argument.

If you do need to reload the firmware on real live sparc setups after driver
setup then someone needs to do some patching.

Unlike you, I actually read the source

Alan

