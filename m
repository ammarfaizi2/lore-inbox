Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317321AbSFCI57>; Mon, 3 Jun 2002 04:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317322AbSFCI56>; Mon, 3 Jun 2002 04:57:58 -0400
Received: from daimi.au.dk ([130.225.16.1]:37999 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317321AbSFCI55>;
	Mon, 3 Jun 2002 04:57:57 -0400
Message-ID: <3CFB2F92.34D174C3@daimi.au.dk>
Date: Mon, 03 Jun 2002 10:57:54 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.LNX.4.33.0206031025400.30424-100000@mail.pronto.tv>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> > > RAID-6 layout: http://www.acnc.com/04_01_06.html
> >
> > If it is supposed to survive two arbitrary disk failures something is
> > wrong with that figure. They store 12 logical sectors in 20 physical
> > sectors across 4 drives. With two lost disks there are 10 physical
> > sectors left from which we want to reconstruct 12 logical sectors.
> > That is impossible.
> 
> Might be the diagram is wrong.

Could be the case, so until I find another description I will
still not know how RAID-6 works.

> 
> > OTOH it is possible to construct a system with optimal capacity and
> > ability to survive any chosen number of disk failures. This can be
> > done using either a Reed-Soloman code or Lagrange interpolation of
> > polynomials over a finite field.
> >
> > However I guess those techniques would be inefficient in software.
> 
> Yeah? That's what the hardware RAID vendors all say, and I yet haven't
> seen one single test where Linux Software RAID can't beat hardware RAID.

Well, I'm not a hardware vendor. I just happen to have tried
doing it in software, and I wasn't able to do it efficiently.

> That is also after some testing I did on a high-end intel server at
> Compaq's lab in Oslo. How can RAID-6 be so much different?

I guess RAID-6 can be done efficiently in software. It is the
other encodings I'm worried about.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
