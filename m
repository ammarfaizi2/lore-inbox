Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSI3UkU>; Mon, 30 Sep 2002 16:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbSI3UkU>; Mon, 30 Sep 2002 16:40:20 -0400
Received: from f6.pav0.hotmail.com ([64.4.33.6]:4367 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261376AbSI3UkS>;
	Mon, 30 Sep 2002 16:40:18 -0400
X-Originating-IP: [213.4.13.153]
From: "Felipe Alfaro Solana" <felipe_alfaro@msn.com>
To: tmolina@cox.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord, IDE-SCSI and 2.5.39
Date: Mon, 30 Sep 2002 22:45:39 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F6wJqHcMtzvFPrcgYax00012f2a@hotmail.com>
X-OriginalArrivalTime: 30 Sep 2002 20:45:39.0718 (UTC) FILETIME=[56186A60:01C268C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try running "cat /dev/pg0"? Does it work for you?

I think "/dev/scd0" is used for normal CD-ROM access, i.e. mounting a CD, 
etc. but I think "/dev/pg0" is the generic interface used for burning CDs, 
erasing CD-RWs, etc.

>From: Thomas Molina <tmolina@cox.net>
>To: Felipe Alfaro Solana <felipe_alfaro@msn.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: cdrecord, IDE-SCSI and 2.5.39
>Date: Mon, 30 Sep 2002 14:45:13 -0500 (CDT)
>MIME-Version: 1.0
>Received: from cpimssmtpa48.msn.com ([207.46.181.112]) by 
>mc2-f39.law16.hotmail.com with Microsoft SMTPSVC(5.0.2195.5600); Mon, 30 
>Sep 2002 12:45:29 -0700
>Received: from dad.molina ([68.13.110.204]) by cpimssmtpa48.msn.com with 
>Microsoft SMTPSVC(5.0.2195.4905); Mon, 30 Sep 2002 12:44:08 -0700
>Received: from localhost (tmolina@localhost)by dad.molina (8.11.6/8.11.6) 
>with ESMTP id g8UJjDn04209;Mon, 30 Sep 2002 14:45:16 -0500
>X-Authentication-Warning: dad.molina: tmolina owned process doing -bs
>X-X-Sender: tmolina@dad.molina
>In-Reply-To: <F758Ts6DdVjkfQWswop000122ba@hotmail.com>
>Message-ID: <Pine.LNX.4.44.0209301443230.3692-100000@dad.molina>
>Return-Path: tmolina@cox.net
>X-OriginalArrivalTime: 30 Sep 2002 19:44:08.0556 (UTC) 
>FILETIME=[BDFDCAC0:01C268B9]
>
>On Mon, 30 Sep 2002, Felipe Alfaro Solana wrote:
>
> > Hello,
> >
> > I have found that cdrecord 1.11a34 has stopped working on linux kernel
> > 2.5.38+. I have a SONY CRX185E3 ATAPI burner and it works fine on 2.4.19
> > using "hdd=ide-scsi" kernel parameter, but with kernel 2.5.38+, cdrecord
> > fails when trying to access the "/dev/pg*" device files. When I run 
>cdrecord
> > -scanbus, it complains with:
> >
> > cdrecord: No such file or directory. Cannot open '/dev/pg*'. Cannot open
> > SCSI driver.
>
>I'm using the cdrecord included in RedHat 7.3 (1.10) with no problems.  My
>cd burner is being seen at /dev/scd0




_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

