Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272466AbRIKOmZ>; Tue, 11 Sep 2001 10:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271032AbRIKOmO>; Tue, 11 Sep 2001 10:42:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34565 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272475AbRIKOl7>; Tue, 11 Sep 2001 10:41:59 -0400
Subject: Re: reboot notifier priority definitions
To: ast@domdv.de (Andreas Steinmetz)
Date: Tue, 11 Sep 2001 15:46:30 +0100 (BST)
Cc: neilb@cse.unsw.edu.au (Neil Brown), linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20010911032626.ast@domdv.de> from "Andreas Steinmetz" at Sep 11, 2001 03:26:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15goo2-0002lV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even then: My servers do have watchdog cards. Unfortunately without the
> priority definitions the watchdog card was shut down prior to the oops. Thus,
> due to missing priority, the system did require hitting the reboot button.
> So some well defined priorization is still required.

Its generally a good idea not to use watchdog cards that have shutdown 
sequences - you can easily hang in the BIOS and a reset then may fix the
box. 
