Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSJACft>; Mon, 30 Sep 2002 22:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbSJACft>; Mon, 30 Sep 2002 22:35:49 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1408 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261451AbSJACfr>;
	Mon, 30 Sep 2002 22:35:47 -0400
Date: Mon, 30 Sep 2002 21:41:04 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Bongani <bonganilinux@mweb.co.za>
cc: Felipe Alfaro Solana <felipe_alfaro@msn.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord, IDE-SCSI and 2.5.39
In-Reply-To: <1033416829.2041.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209302136240.961-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Sep 2002, Bongani wrote:

> On Mon, 2002-09-30 at 21:45, Thomas Molina wrote:
> > On Mon, 30 Sep 2002, Felipe Alfaro Solana wrote:
> > 
> > > Hello,
> > > 
> > > I have found that cdrecord 1.11a34 has stopped working on linux kernel 
> > > 2.5.38+. I have a SONY CRX185E3 ATAPI burner and it works fine on 2.4.19 
> > > using "hdd=ide-scsi" kernel parameter, but with kernel 2.5.38+, cdrecord 
> > > fails when trying to access the "/dev/pg*" device files. When I run cdrecord 
> > > -scanbus, it complains with:
> > > 
> > > cdrecord: No such file or directory. Cannot open '/dev/pg*'. Cannot open 
> > > SCSI driver.
> > 
> > I'm using the cdrecord included in RedHat 7.3 (1.10) with no problems.  My 
> > cd burner is being seen at /dev/scd0
> > 
> 
> Which kernel are you running? I have compiled ide-scsi support into
> 2.5.39 and I get an Oops after booting.
> 

I'm using kernel 2.5.39.  I've used various flavors of linus' bk tree and 
haven't seen any problems.  However, upon further review, I can cause oops 
on request when rmmod sr_mod or ide-scsi.  I'm going to write up a full 
report tomorrow, but it is similar to what others have reported.  I have 
to get up at 0230 in the morning so it's time for bed now.



