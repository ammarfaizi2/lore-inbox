Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319295AbSIKTVb>; Wed, 11 Sep 2002 15:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319297AbSIKTVb>; Wed, 11 Sep 2002 15:21:31 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:25296 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S319295AbSIKTVa>; Wed, 11 Sep 2002 15:21:30 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Oleg Drokin <green@namesys.com>
Subject: Re: [reiserfs-list] [BK] ReiserFS file write bug fix for 2.4
Date: Wed, 11 Sep 2002 21:37:22 +0200
User-Agent: KMail/1.4.3
References: <3D7F7783.6030804@namesys.com> <200209111934.11373.Dieter.Nuetzel@hamburg.de> <20020911215310.A1504@namesys.com>
In-Reply-To: <20020911215310.A1504@namesys.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209112137.22422.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 19:53, Oleg Drokin wrote:
> Hello!
>
> On Wed, Sep 11, 2002 at 07:34:11PM +0200, Dieter N?tzel wrote:
> > On Wednesday 11 September 2002 19:04, Hans Reiser wrote:
> > > Well, at least getting the new file write code into pre6 found this bug
> > > for us....  please apply.
> >
> > What is the "right" way to get the new block allocation going?
>
> use 2.4.19-pre2+ and it is in there ;)

You meant 2.4.20-pre2, didn't you?

> > The mount option (-o alloc=prealloc min=4:preallocsize=9) only or better
> > a "reformat"?
>
> Those mount options are no longer needed starting from 2.4.20-pre6.
> They are default. Reformat is not needed, but all the blocks allocated by
> old allocator will remain at their old places of course.
>
> Bye,
>     Oleg

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)

