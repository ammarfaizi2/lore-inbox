Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316396AbSEOPLD>; Wed, 15 May 2002 11:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316397AbSEOPLC>; Wed, 15 May 2002 11:11:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29459 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316396AbSEOPLC>; Wed, 15 May 2002 11:11:02 -0400
Subject: Re: Adaptec Aic7xxx driver & 2.4.19pre8aa2
To: andrea@suse.de (Andrea Arcangeli)
Date: Wed, 15 May 2002 16:30:19 +0100 (BST)
Cc: gibbs@scsiguy.com (Justin T. Gibbs), andy@spylog.ru (Andrey Nekrasov),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020515164802.GG25593@dualathlon.random> from "Andrea Arcangeli" at May 15, 2002 06:48:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1780jL-0002Ac-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >Hardware motherboard: Intel "Lancewood" L440GX, SCSI integrated, last BIOS/BMC

440GX

> search across the 2.4.19pre patches (from pre2 to pre8) that would limit
> the bug to a certain diff. thanks,

No need. The 440GX stuff is a known disaster area. You must use APIC support
on those and Intel doesn't want to be helpful on non APIC stuff.
