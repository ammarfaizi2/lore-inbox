Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSDGNQD>; Sun, 7 Apr 2002 09:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313302AbSDGNQC>; Sun, 7 Apr 2002 09:16:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47621 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313300AbSDGNQC>; Sun, 7 Apr 2002 09:16:02 -0400
Subject: Re: WatchDog Driver Updates
To: rob@osinvestor.com (Rob Radez)
Date: Sun, 7 Apr 2002 14:32:46 +0100 (BST)
Cc: rmk@arm.linux.org.uk (Russell King), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204070658280.3791-100000@pita.lan> from "Rob Radez" at Apr 07, 2002 06:58:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uCmk-00062n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Maybe Alan would like to comment and clear up this issue - I believe the
> > interface was Alan's design.  Certainly Alan wrote most of the early
> > watchdog drivers.
> 
> Ok, well, there's a new patch up at http://osinvestor.com/bigwatchdog-2.diff
> that does these changes.

They should follow the spec. Most follow it but sometimes somewhat loosely.
In the case of checking if its running many cards can only trust the
hardware not probe it
