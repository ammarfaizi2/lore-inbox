Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSFERoh>; Wed, 5 Jun 2002 13:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSFERog>; Wed, 5 Jun 2002 13:44:36 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:523 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315611AbSFERof> convert rfc822-to-8bit; Wed, 5 Jun 2002 13:44:35 -0400
Date: Wed, 5 Jun 2002 10:42:42 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Kasper Dupont <kasperd@daimi.au.dk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALi IDE problem
In-Reply-To: <3CFC9C08.9D73FF62@daimi.au.dk>
Message-ID: <Pine.LNX.4.10.10206051042201.23643-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am away for the week, but will get back to you.


On Tue, 4 Jun 2002, Kasper Dupont wrote:

> Kasper Dupont wrote:
> > 
> > Andre Hedrick wrote:
> > >
> > > Kasper,
> > >
> > > http://www.linuxdiskcert.org/ide-2.4.19-p8-ac1.all.convert.10.patch.bz2
> > > http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.10.patch.bz2
> > >
> > > Please try this on top of a stock 2.4.19-pre8-ac1 plus patch.
> > > Also try a stock 2.4.19-pre7 plus patch.
> > >
> > > First, at line 553.
> > >
> > > #define ALI_INIT_CODE_TEST
> > >
> > > Change to
> > >
> > > #undef ALI_INIT_CODE_TEST
> > 
> > Many hourse of kernel compilations later:
> > 
> > The following works:
> > -pre7
> > -pre8-ac1
> > -pre8-ac2
> > 
> > The following fails:
> > -pre7 with ide patch
> > -pre8-ac1 with ide patch
> > -pre8-ac3
> > -pre8-ac4
> > -pre8-ac5
> > 
> > Changing ALI_INIT_CODE_TEST doesn't help.
> > It fails both with #define and #undef.
> > 
> > Perhaps I should try reverting the patch
> > against -pre9-ac3?
> 
> Reverting the patch against 2.4.19-pre9-ac3 seems to solve my
> problem. Now DMA works. (A single hunk got rejected and had
> to be applied by hand.)
> 
> -- 
> Kasper Dupont -- der bruger for meget tid på usenet.
> For sending spam use mailto:razor-report@daimi.au.dk
> 

Andre Hedrick
LAD Storage Consulting Group

