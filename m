Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131012AbRCFQql>; Tue, 6 Mar 2001 11:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131009AbRCFQqW>; Tue, 6 Mar 2001 11:46:22 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16650 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131002AbRCFQqS>; Tue, 6 Mar 2001 11:46:18 -0500
Subject: Re: Annoying CD-rom driver error messages
To: law@sgi.com (LA Walsh)
Date: Tue, 6 Mar 2001 16:49:07 +0000 (GMT)
Cc: atm@pinky.penguinpowered.com (God), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <3AA510C6.7A2190D8@sgi.com> from "LA Walsh" at Mar 06, 2001 08:31:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aKe6-00010k-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Then it seems the less ideal question is what is the "approved and recommended
> way for a program to "poll" such devices to check for 'changes' and 'media type'
> without the kernel generating spurious WARNINGS/ERRORS?

The answer to that could probably fill a book unfortunately. You need to use
the various mtfuji and other ata or scsi query commands intended to notify you
politely of media and other status changes

