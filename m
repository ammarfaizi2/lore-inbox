Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317346AbSFCJ7x>; Mon, 3 Jun 2002 05:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317345AbSFCJ7x>; Mon, 3 Jun 2002 05:59:53 -0400
Received: from [62.70.58.70] ([62.70.58.70]:41425 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317343AbSFCJ7w> convert rfc822-to-8bit;
	Mon, 3 Jun 2002 05:59:52 -0400
Message-Id: <200206030959.g539xXb31139@mail.pronto.tv>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: Pronto TV AS
To: "Christian Vik" <cvik@vanadis.no>
Subject: Re: SV: RAID-6 support in kernel?
Date: Mon, 3 Jun 2002 11:59:33 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <A2C65A3296DA4A4FB30DB57A9A464A16436851@exchange.lan.vanadis.no>
Cc: linux-kernel@vger.kernel.org, Kasper Dupont <kasperd@daimi.au.dk>,
        linux-raid@vger.kernel.org, dstephenson@snapserver.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > RAID-6 layout: http://www.acnc.com/04_01_06.html
> > >
>  > > If it is supposed to survive two arbitrary disk failures something is
> > > wrong with that figure. They store 12 logical sectors in 20 physical
> > > sectors across 4 drives. With two lost disks there are 10 physical
> > > sectors left from which we want to reconstruct 12 logical sectors.
> > > That is impossible.
> >
> > Might be the diagram is wrong.

> Could be the case, so until I find another description I will
> still not know how RAID-6 works.

Below is a (patented?) version that works. This is from the linux-raid list

>  A1   A2  (P1) (PA)
> (P2) (PB)  B2   B1
>  C4   C3  (PC) (P3)
> (PD) (P4)  D3   D4
>
> Disclaimer: I took that from Patent 6,353,895.  If you look it up you'll see
> a lot of different schemes and discussion of XOR-based RAID 6, in language
> disguised as English.  You'll also see that I'm listed as the inventor.
> That's four companies back for me, but my current employer unknowingly
> has some rights to it, so I hope it will see the light of day sometime.
>
> Dale Stephenson
> steph@snapserver.com

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.
