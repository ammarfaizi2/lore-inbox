Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbRFNIUc>; Thu, 14 Jun 2001 04:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbRFNIUW>; Thu, 14 Jun 2001 04:20:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30729 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261459AbRFNIUL>; Thu, 14 Jun 2001 04:20:11 -0400
Subject: Re: Problems with arch/i386/kernel/apm.c
To: mochel@transmeta.com (Patrick Mochel)
Date: Thu, 14 Jun 2001 09:18:18 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        jgolds@resilience.com (Jeff Golds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10106121639100.13607-100000@nobelium.transmeta.com> from "Patrick Mochel" at Jun 12, 2001 04:48:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ASKY-0004Le-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus confirmed this assumption, but it may turn out to not be the case.

It isnt the case. It's also horrible for debugging if you dont do it two
stage because with two stages you can force some restores to be done with
irqs off so you can see where the bug is
