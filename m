Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287854AbSAIQt0>; Wed, 9 Jan 2002 11:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287855AbSAIQtR>; Wed, 9 Jan 2002 11:49:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6415 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287854AbSAIQtF>; Wed, 9 Jan 2002 11:49:05 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: akpm@zip.com.au (Andrew Morton)
Date: Wed, 9 Jan 2002 17:00:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3C3BD053.DED314A9@zip.com.au> from "Andrew Morton" at Jan 08, 2002 09:08:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OM59-0001hQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The high-end audio synth guys claim that two milliseconds is getting
> to be too much.  They are generating real-time audio and they do
> have more than one round-trip through the software.  It adds up.

Most of the stuff I've seen from high end audio people consists of
overthreaded, chains of code written without any consideration for the
actual cost of execution. There are exceptions - including
people dynamically compiling filters to get ideal cache and latency 
behaviour, but not enough.

Alan
