Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280281AbRKIXRR>; Fri, 9 Nov 2001 18:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280288AbRKIXQ5>; Fri, 9 Nov 2001 18:16:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14093 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280281AbRKIXQv>; Fri, 9 Nov 2001 18:16:51 -0500
Subject: Re: Disk Performance
To: andersen@codepoet.org
Date: Fri, 9 Nov 2001 23:24:01 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel), ben@genesis-one.com (Ben Israel),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011109155309.A14308@codepoet.org> from "Erik Andersen" at Nov 09, 2001 03:53:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E162L0D-0004dJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > # hdparm -d1 /dev/hda
> > 
> > (not enabled by default because it corrupts data with some
> > old chipsets and/or disks)
> 
> But wouldn't it make more sense to enable DMA by default, except 
> for a set of blacklisted chipsets, rather then disabling it for 
> everybody just because some older chipsets are crap?

Its a configuration option. Most vendors I know set it to enable DMA except
on blacklisted or non PCI devices
