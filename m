Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132415AbRA0Jry>; Sat, 27 Jan 2001 04:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132447AbRA0Jro>; Sat, 27 Jan 2001 04:47:44 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:62633 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S132444AbRA0Jrf>; Sat, 27 Jan 2001 04:47:35 -0500
Message-ID: <3A729920.D35DAD4F@Home.com>
Date: Sat, 27 Jan 2001 04:47:12 -0500
From: Shawn Starr <Shawn.Starr@Home.com>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NOT PROBLEM]: Under 2.4.X hdparm displays device names backwards?;)
In-Reply-To: <Pine.LNX.4.31.0101270944180.26796-100000@athlon.local>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I never noticed that though. Yes, -i does display it correctly.

davej@suse.de wrote:

> On Sat, 27 Jan 2001, Shawn Starr wrote:
>
> > This is what the device names are:
> > hda: FUJITSU MPE3064AT, ATA DISK drive
> > hdb: WDC AC32500H, ATA DISK drive
> > here's what they are with hdparm:
> >  Model=UFIJST UPM3E60A4 T                      , FwRev=DE0--380,
> >  Model=DW CCA2305H0                            , FwRev=210.H721,
> >
> > hehe, might wanna fix that ;-)
>
> This is correct behaviour.
> You want hdparm -i not hdparm -I which reads info from the drive
> without doing endian changes.
>
> regards,
>
> Davej.
>
> --
> | Dave Jones.        http://www.suse.de/~davej
> | SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
