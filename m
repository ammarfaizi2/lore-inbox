Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSCTBko>; Tue, 19 Mar 2002 20:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311180AbSCTBkZ>; Tue, 19 Mar 2002 20:40:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41732 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311121AbSCTBkV>; Tue, 19 Mar 2002 20:40:21 -0500
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP (RH7.2)
To: ken@irridia.com (Ken Brownfield)
Date: Wed, 20 Mar 2002 01:56:23 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), m.knoblauch@TeraPort.de,
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <20020319193333.C15811@asooo.flowerfire.com> from "Ken Brownfield" at Mar 19, 2002 07:33:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nVKx-0000zB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It would have been "fine" if the serverworks driver didn't leave UDMA on
> when it's off by default in the CONFIG.  At least then you would be

That was a merge error from way back - now fixed (2.4.19pre) 

> Quite possible.  I'm only seeing this on ServerWorks mobos with IDE as
> primary (vs SCSI).  I heard third-hand via a FreeBSD post that it's an
> OSB4 issue effecting them as well.  Are Seagates a requirement for the
> issues?

I wish I knew. If I did I'd slap a "no seagate UDMA" check in that driver
pronto.

> As to whether they can reproduce it... I'm not holding my breath for
> them to try.

They tried. They asked a lot of questions and while they failed I'm certain
the actually did try. While we've had some problems with serverworks
(notably no ECC docs which for some enterprise customers is a showstopper)
in general they are very co-operative nowdays, although they do like NDA's
and the like first.

Alan
