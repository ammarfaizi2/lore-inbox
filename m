Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264804AbRF1Wlc>; Thu, 28 Jun 2001 18:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264812AbRF1WlW>; Thu, 28 Jun 2001 18:41:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56337 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264804AbRF1WlK>; Thu, 28 Jun 2001 18:41:10 -0400
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
To: bcrl@redhat.com (Ben LaHaise)
Date: Thu, 28 Jun 2001 23:40:27 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), jes@sunsite.dk (Jes Sorensen),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <Pine.LNX.4.33.0106281830480.32276-100000@toomuch.toronto.redhat.com> from "Ben LaHaise" at Jun 28, 2001 06:31:39 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FkSZ-0007mc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, but that's not a good enough answer if 2.5 takes the same 2 years
> that 2.3 took.  Define the API so that people can at least write their
> drivers to the spec, or else suffer the consequences of people doing their
> own thing.

At which point we can also then drop it into 2.4 so that all the non IA64
architectures just happen to resolve to the same old 32bit calls via
a tiny set of #defines and the IA64 - which requires it for basically
everything anyway - can use it natively, and if they get it wrong suffer
their own problems without annoying anyone else

Alan

