Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbRFPN1m>; Sat, 16 Jun 2001 09:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264623AbRFPN1c>; Sat, 16 Jun 2001 09:27:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14091 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264622AbRFPN1S>; Sat, 16 Jun 2001 09:27:18 -0400
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 16 Jun 2001 14:25:15 +0100 (BST)
Cc: eric@brouhaha.com (Eric Smith), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), arjanv@redhat.com, mj@ucw.cz
In-Reply-To: <3B2A9975.D648D55B@mandrakesoft.com> from "Jeff Garzik" at Jun 15, 2001 07:25:41 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15BG4h-000842-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would love to just define it unconditionally for x86, but I believe
> Martin said that causes problems with some hardware, and the way the
> BIOS has set up that hardware.  (details anyone?)

Im not sure unconditionally is wise. However turning it into a routine that
walks the PCI bus tree and returns 1 if  a duplicate is found seems to be
a little bit less likely to cause suprises
