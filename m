Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbRE2GHC>; Tue, 29 May 2001 02:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbRE2GGv>; Tue, 29 May 2001 02:06:51 -0400
Received: from www.wen-online.de ([212.223.88.39]:58125 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S262650AbRE2GGi>;
	Tue, 29 May 2001 02:06:38 -0400
Date: Tue, 29 May 2001 08:04:11 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: =?ISO-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        safemode <safemode@voicenet.com>, "G. Hugh Song" <ghsong@kjist.ac.kr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Plain 2.4.5 VM...
In-Reply-To: <3B1327D5.6484E61E@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0105290748260.614-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001, Jeff Garzik wrote:

> > On Tuesday 29 May 2001 00:10, Jakob Østergaard wrote:
> >
> > > > > Mem: 381608K av, 248504K used, 133104K free, 0K shrd, 192K
> > > > > buff
> > > > > Swap: 255608K av, 255608K used, 0K free 215744K
> > > > > cached
> > > > >
> > > > > Vanilla 2.4.5 VM.
> >
> > > It's not a bug.  It's a feature.  It only breaks systems that are run with
> > > "too little" swap, and the only difference from 2.2 till now is, that the
> > > definition of "too little" changed.
>
> I am surprised as many people as this are missing,
>
> * when you have an active process using ~300M of VM, in a ~380M machine,
> 2/3 of the machine's RAM should -not- be soaked up by cache

Emphatic yes.  We went from cache collapse to cache bloat.  IMHO, the
bugfix for collapse exposed other problems.  I posted a patch which
I believe demonstrated that pretty well.  (i also bet Rik a virtual
beer that folks would knock on his mailbox when 2.4.5 was released.
please cc him somebody.. i want my brewski;)

	-Mike

