Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282229AbRK2Aod>; Wed, 28 Nov 2001 19:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282228AbRK2AoO>; Wed, 28 Nov 2001 19:44:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282200AbRK2Anz>; Wed, 28 Nov 2001 19:43:55 -0500
Subject: Re: [PATCH] vc_tty addition
To: jsimmons@transvirtual.com (James Simmons)
Date: Thu, 29 Nov 2001 00:52:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        linuxconsole-dev@lists.sourceforge.net (Linux console project)
In-Reply-To: <Pine.LNX.4.10.10111281627190.4098-100000@www.transvirtual.com> from "James Simmons" at Nov 28, 2001 04:39:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169FR1-0006jZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> accessing /dev/console only effects the first console in the list instead
> of all of them. If this is true then that means /dev/consoel can exist
> without /dev/tty which could be a good thing.

Currently the "console" doesn't need to include a tty device - if its only
being hit with printk output. 
