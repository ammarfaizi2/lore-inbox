Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319075AbSIDFxy>; Wed, 4 Sep 2002 01:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319074AbSIDFxy>; Wed, 4 Sep 2002 01:53:54 -0400
Received: from rom.cscaper.com ([216.19.195.129]:11687 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S319073AbSIDFxw>;
	Wed, 4 Sep 2002 01:53:52 -0400
Subject: IDE-DVD problems [excuse former idiotic topic]
Content-Transfer-Encoding: 7BIT
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Benjamin LaHaise <bcrl@redhat.com>
From: "Joseph N. Hall" <joseph@5sigma.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Tue, 3 Sep 2002 23:00 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20020904055352Z319073-685+42531@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, DMA makes the drive completely non functional and eventually
hangs the machine after some amount of attempted use.  This is
regardless of when DMA is enabled, whether via the standard
RedHat "harddiskn" mechanism or manually with hdparm.

  -joseph

On Tue, 3 Sep 2002 22:37:57 -0700, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> 
> Have you tried enabling DMA on the drive?
> 
> Matt
> 
> On Tue, Sep 03, 2002 at 06:45:00PM -0700, Joseph N. Hall wrote:
> > Dear Kernel Folks,
> >
> > I am trying to determine the cause of the poor performance of a
> > an IDE DVD device on my new machine.  I have an IDE Panasonic DF-210-type
> > DVD-RAM/R/ROM in a new machine with Soyo KT333 motherboard.  It
> > transfers data slowly (below DVD speed), consumes large amounts of
> > system time, and slows down the user interface and even system
> > clock (which can run as slow as 1/4 speed while the drive is
> > going).
> >
> > The interrupt ERR count below seems to be mostly related to use
> > of the DVD drive.
> >
> > Maybe it's something simple.  If not, I'll be glad to do further
> > work to help diagnose the problem.

