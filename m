Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbRGZMEh>; Thu, 26 Jul 2001 08:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbRGZME1>; Thu, 26 Jul 2001 08:04:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15116 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267732AbRGZMEN>; Thu, 26 Jul 2001 08:04:13 -0400
Subject: Re: 2.4.7 cyclades-Y crash
To: kas@informatics.muni.cz (Jan Kasprzak)
Date: Thu, 26 Jul 2001 13:05:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010726130354.A1024@informatics.muni.cz> from "Jan Kasprzak" at Jul 26, 2001 01:03:54 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PjtM-0003e6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Alan Cox wrote:
> : > connected to 16-port box). The 2.4.7 kernel crashes when initializing the
> : > cyclades driver (either as a module or a built-in driver). I've tried
> : > the stock kernel from Red Hat 7.1, and the cyclades.o module causes the
> : > system to lock up when loaded.
> : 
> : Is this an SMP box ?
> 
> 	No. Pentium 233 MMX, 32M RAM, RedHat 7.1. Can this be a compiler
> problem?

Don't think so. The reason I asked was there were locking fixes to it, but
they wouldnt impact non SMP users. Does 2.4.6 work ?
