Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317503AbSF2CDw>; Fri, 28 Jun 2002 22:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317504AbSF2CDv>; Fri, 28 Jun 2002 22:03:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64273 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317503AbSF2CDu>; Fri, 28 Jun 2002 22:03:50 -0400
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Sat, 29 Jun 2002 03:28:50 +0100 (BST)
Cc: ink@jurassic.park.msu.ru (Ivan Kokshaysky),
       alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Jun 28, 2002 05:31:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17O7yk-0007w5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just backed it on my BK repository.

Please back it back in. The bug is the Alpha port. Alpha needs its own OSF
readv/writev entry point which masks the top bits.
