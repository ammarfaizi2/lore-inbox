Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277244AbRJDWFf>; Thu, 4 Oct 2001 18:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277250AbRJDWF2>; Thu, 4 Oct 2001 18:05:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45072 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277244AbRJDWFT>; Thu, 4 Oct 2001 18:05:19 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: linux-kernel@alex.org.uk
Date: Thu, 4 Oct 2001 23:10:44 +0100 (BST)
Cc: mingo@elte.hu, hadi@cyberus.ca (jamal), linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru (Alexey Kuznetsov),
        Robert.Olsson@data.slu.se (Robert Olsson),
        bcrl@redhat.com (Benjamin LaHaise), netdev@oss.sgi.com,
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), sim@netnation.com (Simon Kirby)
In-Reply-To: <302737894.1002234496@[195.224.237.69]> from "Alex Bligh - linux-kernel" at Oct 04, 2001 10:28:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pGhY-0004Qz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In at least one environment known to me (router), I'd rather it
> kept accepting packets, and f/w'ing them, and didn't switch VTs etc.
> By dropping down performance, you've made the DoS attack even
> more successful than it would otherwise have been (the kiddie
> looks at effect on the host at the end).

You only think that. After a few minutes the kiddie pulls down your routing
because your route daemons execute no code. Also during the attack your sshd
wont run so you cant log in to find out what is up
