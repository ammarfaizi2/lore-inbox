Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284842AbRLFAQT>; Wed, 5 Dec 2001 19:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284860AbRLFAQK>; Wed, 5 Dec 2001 19:16:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15624 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284890AbRLFAP7>; Wed, 5 Dec 2001 19:15:59 -0500
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
To: pavel@suse.cz (Pavel Machek)
Date: Thu, 6 Dec 2001 00:20:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        davidel@xmailserver.org (Davide Libenzi),
        lm@bitmover.com (Larry McVoy),
        phillips@bonn-fries.net (Daniel Phillips),
        hps@intermeta.de (Henning Schmiedehausen),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <20011204232240.A117@elf.ucw.cz> from "Pavel Machek" at Dec 04, 2001 11:22:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BmHS-00089l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that was just before 2.4 because that was when I got it... Don't flush
> drivers too fast, please... If you kill drivers during 2.5, people
> will not notice, and even interesting drivers will get killed. Killing
> them during 2.6.2 might be better.

They need to die before 2.6. I'm all for leaving the code present and the
ability to select

	Expert
		Drivers that need fixing
			Clockwork scsi controller, windup mark 2

in 2.6 so that people do fix them

Alan
