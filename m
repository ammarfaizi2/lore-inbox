Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293162AbSCTAKg>; Tue, 19 Mar 2002 19:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293182AbSCTAK1>; Tue, 19 Mar 2002 19:10:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4371 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293162AbSCTAKM>; Tue, 19 Mar 2002 19:10:12 -0500
Subject: Re: [patch] My AMD IDE driver, v2.7
To: pavel@suse.cz (Pavel Machek)
Date: Wed, 20 Mar 2002 00:25:58 +0000 (GMT)
Cc: vojtech@suse.cz (Vojtech Pavlik), pavel@suse.cz (Pavel Machek),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        galibert@pobox.com (Olivier Galibert),
        linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <20020319212130.GG12260@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at Mar 19, 2002 10:21:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nTvS-0000md-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > receives a command when not spinned up. You need to issue a wake command
> > first, which hdparm doesn't, it just leaves it to the kernel to issue a
> > read command or whatever to wake the drive ...
> 
> Is this common disk bug, or are they permitted to behave like that?

Its not that common, but these sort of things happen sometimes. IDE is
very much a defensive driver 
