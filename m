Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261324AbSI3UFQ>; Mon, 30 Sep 2002 16:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbSI3UFQ>; Mon, 30 Sep 2002 16:05:16 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:7874 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id <S261324AbSI3UFP>; Mon, 30 Sep 2002 16:05:15 -0400
Subject: Re: cdrecord, IDE-SCSI and 2.5.39
From: Bongani <bonganilinux@mweb.co.za>
To: Thomas Molina <tmolina@cox.net>
Cc: Felipe Alfaro Solana <felipe_alfaro@msn.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209301443230.3692-100000@dad.molina>
References: <Pine.LNX.4.44.0209301443230.3692-100000@dad.molina>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 30 Sep 2002 22:13:46 +0200
Message-Id: <1033416829.2041.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 21:45, Thomas Molina wrote:
> On Mon, 30 Sep 2002, Felipe Alfaro Solana wrote:
> 
> > Hello,
> > 
> > I have found that cdrecord 1.11a34 has stopped working on linux kernel 
> > 2.5.38+. I have a SONY CRX185E3 ATAPI burner and it works fine on 2.4.19 
> > using "hdd=ide-scsi" kernel parameter, but with kernel 2.5.38+, cdrecord 
> > fails when trying to access the "/dev/pg*" device files. When I run cdrecord 
> > -scanbus, it complains with:
> > 
> > cdrecord: No such file or directory. Cannot open '/dev/pg*'. Cannot open 
> > SCSI driver.
> 
> I'm using the cdrecord included in RedHat 7.3 (1.10) with no problems.  My 
> cd burner is being seen at /dev/scd0
> 

Which kernel are you running? I have compiled ide-scsi support into
2.5.39 and I get an Oops after booting.

