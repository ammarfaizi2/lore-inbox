Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284892AbRLFAd6>; Wed, 5 Dec 2001 19:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbRLFAds>; Wed, 5 Dec 2001 19:33:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29960 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284892AbRLFAdm>; Wed, 5 Dec 2001 19:33:42 -0500
Subject: Re: VIA acknowledges North Bridge bug (AKA Linux Kernel with Athlon
To: calin@ajvar.org (Calin A. Culianu)
Date: Thu, 6 Dec 2001 00:41:36 +0000 (GMT)
Cc: troels@thule.no (Troels Walsted Hansen), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0112051609200.21129-100000@rtlab.med.cornell.edu> from "Calin A. Culianu" at Dec 05, 2001 04:09:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BmbY-0008DS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So does this mean we will be seeing a patch that clears bits 6,7, and 8 in
> register 55 on the northbridge soon?

We already have one. The Linux folks saw the problem much earlier than
windows people because our athlon optimised memory copies triggered it
reliably on many boards.

Whats sad is its taken VIA this long to finally acknowledge a bug that we
have shown existed months and months ago, and even had Linux fixes for a 
while in 2.4

Alan
