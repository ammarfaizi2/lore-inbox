Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319402AbSH3DSm>; Thu, 29 Aug 2002 23:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319404AbSH3DSm>; Thu, 29 Aug 2002 23:18:42 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:48655
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319402AbSH3DSm>; Thu, 29 Aug 2002 23:18:42 -0400
Date: Thu, 29 Aug 2002 20:04:58 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Meelis Roos <mroos@tartu.cyber.ee>, linux-kernel@vger.kernel.org
Subject: Re: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
In-Reply-To: <20020829224621.A4175@ucw.cz>
Message-ID: <Pine.LNX.4.10.10208292003080.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good cause then I take responsiblity for it.

On Thu, 29 Aug 2002, Vojtech Pavlik wrote:

> On Thu, Aug 29, 2002 at 12:37:19PM -0700, Andre Hedrick wrote:
> 
> > On Thu, 29 Aug 2002, Meelis Roos wrote:
> > 
> > > pcibus = 33333
> > > 00:07.1 vendor=8086 device=7111 class=0101 irq=0 base4=f001
> > > ----------PIIX BusMastering IDE Configuration---------------
> > > Driver Version:                     1.3
> > > South Bridge:                       28945
> > > Revision:                           IDE 0x1
> > > Highest DMA rate:                   UDMA33
> > > BM-DMA base:                        0xf000
> > > PCI clock:                          33.3MHz
> > > -----------------------Primary IDE-------Secondary IDE------
> > > Enabled:                      yes                 yes
> > > Simplex only:                  no                  no
> > > Cable Type:                   40w                 40w
> > > -------------------drive0----drive1----drive2----drive3-----
> > > Prefetch+Post:        yes       yes       yes       yes
> > > Transfer Mode:        PIO       PIO       PIO       PIO
> > > Address Setup:       90ns      90ns      90ns      90ns
> > > Cmd Active:         360ns     360ns     360ns     360ns
> > > Cmd Recovery:       540ns     540ns     540ns     540ns
> > > Data Active:         90ns      90ns      90ns      90ns
> > > Data Recovery:       30ns      30ns      90ns      30ns
> > > Cycle Time:         120ns     120ns     180ns     120ns
> > > Transfer Rate:   16.6MB/s  16.6MB/s  11.1MB/s  16.6MB/s
> > 
> > That is not my work and you are on your own for that mess.
> > That looks straight out of 2.5.30.
> 
> Don't be so quick with shooing people away - this is the output of the
> 'atapci' userspace program. It only reads the PCI config registers and

Well if atapci is that complete then I see no reason to keep proc about.
So if it needs to go we delete it.

Regards,

Andre Hedrick
LAD Storage Consulting Group

