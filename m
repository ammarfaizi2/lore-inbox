Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318888AbSIDOvJ>; Wed, 4 Sep 2002 10:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318911AbSIDOvJ>; Wed, 4 Sep 2002 10:51:09 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:26862 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318888AbSIDOvH>; Wed, 4 Sep 2002 10:51:07 -0400
Date: Wed, 4 Sep 2002 10:55:37 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Joseph N. Hall" <joseph@5sigma.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE-DVD problems [excuse former idiotic topic]
Message-ID: <20020904105537.A1394@redhat.com>
References: <200209040542.g845gf100948@mx1.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209040542.g845gf100948@mx1.redhat.com>; from joseph@5sigma.com on Tue, Sep 03, 2002 at 11:00:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried commenting out the hdparm commands in the initscripts and 
booted with a kernel that enables DMA (instead of using hdparm -d1)?

		-ben

On Tue, Sep 03, 2002 at 11:00:00PM -0700, Joseph N. Hall wrote:
> Yes, DMA makes the drive completely non functional and eventually
> hangs the machine after some amount of attempted use.  This is
> regardless of when DMA is enabled, whether via the standard
> RedHat "harddiskn" mechanism or manually with hdparm.
> 
>   -joseph
> 
> On Tue, 3 Sep 2002 22:37:57 -0700, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> > 
> > Have you tried enabling DMA on the drive?
> > 
> > Matt
> > 
> > On Tue, Sep 03, 2002 at 06:45:00PM -0700, Joseph N. Hall wrote:
> > > Dear Kernel Folks,
> > >
> > > I am trying to determine the cause of the poor performance of a
> > > an IDE DVD device on my new machine.  I have an IDE Panasonic DF-210-type
> > > DVD-RAM/R/ROM in a new machine with Soyo KT333 motherboard.  It
> > > transfers data slowly (below DVD speed), consumes large amounts of
> > > system time, and slows down the user interface and even system
> > > clock (which can run as slow as 1/4 speed while the drive is
> > > going).
> > >
> > > The interrupt ERR count below seems to be mostly related to use
> > > of the DVD drive.
> > >
> > > Maybe it's something simple.  If not, I'll be glad to do further
> > > work to help diagnose the problem.

-- 
"You will be reincarnated as a toad; and you will be much happier."
