Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276576AbRI2S1T>; Sat, 29 Sep 2001 14:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276577AbRI2S1A>; Sat, 29 Sep 2001 14:27:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7953 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276576AbRI2S0x>; Sat, 29 Sep 2001 14:26:53 -0400
Subject: Re: all files are executable in vfat
To: Florian.Weimer@RUS.Uni-Stuttgart.DE (Florian Weimer)
Date: Sat, 29 Sep 2001 19:32:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <tg7kuhsxsc.fsf@mercury.rus.uni-stuttgart.de> from "Florian Weimer" at Sep 29, 2001 07:37:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nOuO-0002di-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Usermode Linux is indeed an option, thanks for the suggestions.
> 
> BTW, which of the journaling file systems support true read-only
> mounts (without replaying the journal and thus writing to disk)?

None of them, but the UML trick works - maybe we need a generic COW loopback
driver one day
