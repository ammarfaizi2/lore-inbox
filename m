Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276609AbRI2UeL>; Sat, 29 Sep 2001 16:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276611AbRI2UeB>; Sat, 29 Sep 2001 16:34:01 -0400
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:1270 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276609AbRI2Udz>; Sat, 29 Sep 2001 16:33:55 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Andre Hedrick <andre@aslab.com>,
        Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Subject: Re: RFC (patch below) Re: ide drive problem?
Date: Sat, 29 Sep 2001 13:34:26 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10109291309050.28810-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10109291309050.28810-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010929203421.MMTA17980.femail28.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 September 2001 01:16 pm, Andre Hedrick wrote:
> This is an error that I am considering removing form the user's view.
> For the very fact/reason you are pointing out; however, it becomse
> more painful when performing error sorting.
>

How about this: Put in a counter that displays the message proposed by 
Christian (hopefully with a quick update to the FAQ noting that if you 
see this, it might be a bad thing after 2.4.SomeRevision) every X times 
the error occurs, and that a boot parameter is added to turn this 
behavior off and return to the old behavior.

> On Sat, 29 Sep 2001, Christian [iso-8859-1] Bornträger wrote:
> > Hi List, Hi Andre,
> >
> > as Mark Hahn made a FAQ entry for the
> >
> > hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> >
> > message, I think we should point all users to this FAQ. I saw this
> > message and questions about it very often in this list, so we
> > should help the users to find a fast solution. You know, only a few
> > people read a manual, even in error case.
> >
> > Now the output looks like:
> >
> > hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> >
> > For further Informations please check:
> > http://www.tux.org/lkml/#s13-3
