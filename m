Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265889AbRF3Lpi>; Sat, 30 Jun 2001 07:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265887AbRF3LpT>; Sat, 30 Jun 2001 07:45:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8975 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265884AbRF3LpL>; Sat, 30 Jun 2001 07:45:11 -0400
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
To: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 30 Jun 2001 12:43:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), adam@yggdrasil.com (Adam J. Richter),
        kaos@ocs.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20010630102024.A12009@flint.arm.linux.org.uk> from "Russell King" at Jun 30, 2001 10:20:24 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15GJAI-0001w1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Err, how can $BAR be undefined?  Configure sets all config variables which
> are answered with 'n' to 'n'.

Welcome to the 'if' statement....

> Can you extract an example where #2 is actually used?

>From a first review I can't - but we need to verify that is the case completely
before we make the change.
