Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263630AbRFNSR5>; Thu, 14 Jun 2001 14:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263608AbRFNSRk>; Thu, 14 Jun 2001 14:17:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52749 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263607AbRFNSRb>; Thu, 14 Jun 2001 14:17:31 -0400
Subject: Re: threading question
To: ognen@gene.pbi.nrc.ca
Date: Thu, 14 Jun 2001 19:15:48 +0100 (BST)
Cc: davidel@xmailserver.org (Davide Libenzi), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0106121546510.11222-100000@gene.pbi.nrc.ca> from "ognen@gene.pbi.nrc.ca" at Jun 12, 2001 03:48:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Abem-00055Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> they are done. This should help it (and avoid the pthread_create,
> pthread_exit). I will implement this and report my results if there is
> interest.

You should also check up the cache colouring. X86 boxes have relatively poor
memory performance and most x86 chips have lousy behaviour when data bounces
between processors or is driven out of cache
