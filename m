Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262468AbRE0V4x>; Sun, 27 May 2001 17:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262470AbRE0V4n>; Sun, 27 May 2001 17:56:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42766 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262468AbRE0V40>; Sun, 27 May 2001 17:56:26 -0400
Subject: Re: Hard lockup switching to X from vc; Matrox G400 AGP
To: rankinc@pacbell.net (Chris Rankin)
Date: Sun, 27 May 2001 22:53:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105272147.f4RLlv300461@twopit.underworld> from "Chris Rankin" at May 27, 2001 02:47:57 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1548U0-0002Ou-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> out the Matrox-supplied mga_drv.o and mga_hal_drv.o modules and
> replace them with the ones from the standard X 4.03 distribution, but
> these are userspace objects and shouldn't be capable of bringing the
> kernel down. (Like I said, the machine can't even be pinged.)

Not really. The matrox code and X server run priviledged and bang on hardware
directly. Its quite easily an X11 bug. Nice to know the free software one
works better than the vendors 8)

