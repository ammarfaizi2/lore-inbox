Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBUNwX>; Wed, 21 Feb 2001 08:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbRBUNwO>; Wed, 21 Feb 2001 08:52:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42762 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129104AbRBUNwD>; Wed, 21 Feb 2001 08:52:03 -0500
Subject: Re: Looking for a way to trigger error on network adapter
To: romieu@cogenit.fr (Francois Romieu)
Date: Wed, 21 Feb 2001 13:55:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010221144521.A18673@se1.cogenit.fr> from "Francois Romieu" at Feb 21, 2001 02:45:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VZjf-00027D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to see how my code bahaves during rare (?) events: an overflow of 
> the RX fifo (256 bytes) and a TX underrun. It's my understanding that if the 
> adapter pains at DMAing, those errors should be triggered.
> Could I/O at a inocuous location (a well-choosen PCI register ?) be enough 
> for that ?

Install XFree86 4.0 on a matrox card. Enable pci retries in the config. Wave
large windows around while running a heavy graphical app.

Thats certainly enough to make several sound cards barf and sulk. The matrox
has a bencmarketing feature where they lock the pci bus to get better winbench
type numbers. They arent the only people who do it and thankfully you can turn
it off, but for this specific case its rather useful 8)

