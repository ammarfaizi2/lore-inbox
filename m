Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbSI3UiQ>; Mon, 30 Sep 2002 16:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSI3UiQ>; Mon, 30 Sep 2002 16:38:16 -0400
Received: from f18.pav0.hotmail.com ([64.4.33.89]:22803 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261374AbSI3UiP>;
	Mon, 30 Sep 2002 16:38:15 -0400
X-Originating-IP: [213.4.13.153]
From: "Felipe Alfaro Solana" <felipe_alfaro@msn.com>
To: bonganilinux@mweb.co.za, tmolina@cox.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord, IDE-SCSI and 2.5.39
Date: Mon, 30 Sep 2002 22:43:36 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F18W2wNu2qI1HoGC9f200011714@hotmail.com>
X-OriginalArrivalTime: 30 Sep 2002 20:43:36.0135 (UTC) FILETIME=[0C6F2570:01C268C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using kernel 2.5.39... It seems to boot and work properly, although I 
still see some issues (the IDE bus led is always lit). I also tried on 
2,5.38 with the same results. I can attach my .config for review, if you 
like.

>From: Bongani <bonganilinux@mweb.co.za>
>To: Thomas Molina <tmolina@cox.net>
>CC: Felipe Alfaro Solana <felipe_alfaro@msn.com>, 
>linux-kernel@vger.kernel.org
>Subject: Re: cdrecord, IDE-SCSI and 2.5.39
>Date: 30 Sep 2002 22:13:46 +0200
>MIME-Version: 1.0
>Received: from cpimssmtpa01.msn.com ([207.46.181.100]) by 
>mc1-f41.law16.hotmail.com with Microsoft SMTPSVC(5.0.2195.5600); Mon, 30 
>Sep 2002 13:10:55 -0700
>Received: from starcraft.mweb.co.za ([196.2.45.78]) by cpimssmtpa01.msn.com 
>with Microsoft SMTPSVC(5.0.2195.4905); Mon, 30 Sep 2002 13:09:27 -0700
>Received: from ndf-dial-196-30-126-122.mweb.co.za 
>([196.30.126.122]:33236)by starcraft.mweb.co.za with esmtp (Exim 4.10)id 
>17w6sC-0003FB-00; Mon, 30 Sep 2002 22:10:32 +0200
>In-Reply-To: <Pine.LNX.4.44.0209301443230.3692-100000@dad.molina>
>References: <Pine.LNX.4.44.0209301443230.3692-100000@dad.molina>
>X-Mailer: Ximian Evolution 1.0.8-3mdk Message-Id: 
><1033416829.2041.1.camel@localhost.localdomain>
>Return-Path: bonganilinux@mweb.co.za
>X-OriginalArrivalTime: 30 Sep 2002 20:09:28.0727 (UTC) 
>FILETIME=[48157A70:01C268BD]
>
>On Mon, 2002-09-30 at 21:45, Thomas Molina wrote:
> > On Mon, 30 Sep 2002, Felipe Alfaro Solana wrote:
> >
> > > Hello,
> > >
> > > I have found that cdrecord 1.11a34 has stopped working on linux kernel
> > > 2.5.38+. I have a SONY CRX185E3 ATAPI burner and it works fine on 
>2.4.19
> > > using "hdd=ide-scsi" kernel parameter, but with kernel 2.5.38+, 
>cdrecord
> > > fails when trying to access the "/dev/pg*" device files. When I run 
>cdrecord
> > > -scanbus, it complains with:
> > >
> > > cdrecord: No such file or directory. Cannot open '/dev/pg*'. Cannot 
>open
> > > SCSI driver.
> >
> > I'm using the cdrecord included in RedHat 7.3 (1.10) with no problems.  
>My
> > cd burner is being seen at /dev/scd0
> >
>
>Which kernel are you running? I have compiled ide-scsi support into
>2.5.39 and I get an Oops after booting.




_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

