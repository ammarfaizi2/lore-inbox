Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313724AbSDWEz4>; Tue, 23 Apr 2002 00:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313792AbSDWEzz>; Tue, 23 Apr 2002 00:55:55 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:50180 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313724AbSDWEzz> convert rfc822-to-8bit; Tue, 23 Apr 2002 00:55:55 -0400
Date: Tue, 23 Apr 2002 06:55:36 +0200 (CEST)
From: tomas szepe <kala@pinerecords.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: =?ISO-8859-15?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: PromiseULTRA100 TX2 ATA66 trouble
In-Reply-To: <Pine.LNX.4.10.10204221708460.24428-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0204230653280.2888-100000@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Really ?

Definitely correct.

convert.6
	- doesn't detect the controller at all

convert.5
	- inits ok
	- doesn't automatically use ATA66 either (have to use 'ide2=ata66')

> Stress of life is frying me, eek!

oh certainly it's not that bad :)


> Andre Hedrick
> LAD Storage Consulting Group
>
> On Tue, 23 Apr 2002, [ISO-8859-15] François Cami wrote:
>
> > tomas szepe wrote:
> >
> > <snip>
> >
> > > Furthermore, applying Andre Hedrick's ide-2.4.19-p7.all.convert.6.patch
> > > causes the kernel to not even recognize the controller. BUUUURN! <g>
> > >
> > > The card is detected as:
> > > Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d68 (rev 02)
> >
> > <snip>
> >
> > Try convert.5 not convert.6
> > convert.6 doesn't recognize my Promise Ultra66 board either.
> >
> > François Cami



T.

pub 1024d/8e316a84 2002-01-29   tomas szepe <kala@pinerecords.com>
openpgp f/print 2955 2eea c4b8 b09e 7ae1  4d5d 68e3 d606 8e31 6a84

