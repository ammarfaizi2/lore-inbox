Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136197AbRDVQND>; Sun, 22 Apr 2001 12:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136196AbRDVQMy>; Sun, 22 Apr 2001 12:12:54 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:12813 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S136203AbRDVQMj>;
	Sun, 22 Apr 2001 12:12:39 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rmk@arm.linux.org.uk (Russell King), philb@gnu.org (Philip Blundell),
        junio@siamese.dhis.twinsun.com, manuel@mclure.org (Manuel McLure),
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <E14rJw2-0005r5-00@the-village.bc.nu>
From: Jes Sorensen <jes@linuxcare.com>
Date: 22 Apr 2001 18:12:16 +0200
In-Reply-To: Alan Cox's message of "Sun, 22 Apr 2001 14:29:51 +0100 (BST)"
Message-ID: <d366fw29sv.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> The recommended compilers for non x86 are different too - eg you
Alan> need 2.96 gcc for IA64, you need 2.95 not egcs for mips and so
Alan> on.

In principle you just need 2.7.2.3 for m68k, but someone decided to
raise the bar for all architectures by putting a check in a common
header file.

Maybe it's time to move that check to the arch include dir instead?

Jes
