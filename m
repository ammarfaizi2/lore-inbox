Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264461AbRF1Vae>; Thu, 28 Jun 2001 17:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264475AbRF1VaY>; Thu, 28 Jun 2001 17:30:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17425 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264461AbRF1VaL>; Thu, 28 Jun 2001 17:30:11 -0400
Subject: Re: VIA 686B/Data Corruption
To: jlaako@pp.htv.fi (Jussi Laako)
Date: Thu, 28 Jun 2001 22:29:52 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3B3BA155.98D3B636@pp.htv.fi> from "Jussi Laako" at Jun 29, 2001 12:27:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FjMG-0007g0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just tested RedHat's 2.4.3-12 and 2.4.5-ac19 on A7V133 mobo. RedHat's kernel
> seems to work without lockups, but 2.4.5-ac19 doesn't (locks up at boot,
> compiled w/o athlon optimization and ACPI), so no changes on that.

Interesting. They should be the same code for the VIA driver.

> 2.4.3-12 although seems to have the reiserfs unmount lock race, so I can't
> use it... :(

Possibly.  If so file that in bugzilla so it gets fixed

