Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSK0DZY>; Tue, 26 Nov 2002 22:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSK0DZY>; Tue, 26 Nov 2002 22:25:24 -0500
Received: from ma-northadams1b-112.bur.adelphia.net ([24.52.166.112]:896 "EHLO
	ma-northadams1b-112.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S261486AbSK0DZX>; Tue, 26 Nov 2002 22:25:23 -0500
Date: Tue, 26 Nov 2002 22:32:33 -0500
From: Eric Buddington <eric@ma-northadams1b-112.bur.adelphia.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ebuddington@wesleyan.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.49: "hdb: cannot handle device with more than 16 heads"
Message-ID: <20021126223233.A141@ma-northadams1b-112.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
References: <20021126125019.A81@ma-northadams1b-112.nad.adelphia.net> <1038335905.2658.65.camel@irongate.swansea.linux.org.uk> <20021126150325.A157@ma-northadams1b-112.nad.adelphia.net> <1038357203.2594.107.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1038357203.2594.107.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 27, 2002 at 12:33:23AM +0000
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 12:33:23AM +0000, Alan Cox wrote:
> On Tue, 2002-11-26 at 20:03, Eric Buddington wrote:
> > Thanks. Disks and partitions are now recognized, but root still won't
> > mount. Reiserfs (the root fs) is compiled in, along with IDE disk
> > support.  I tried getting rid of the advanced partitopn types options,
> > which eliminated the MS-DOS partition table message, but did not
> > otherwise change things.
> > 
> > The hdc error is also unexpected, unless it's simply the result of no
> > CD in the drive.
> > 
> > I hope this isn't another silly thing I'm missing.
> 
> I'd start by turning off devfs

This eliminates the problem, at least enough to mount the root fs. My
system relies on devfs though (/dev is unpopulated), so I can't say
much more than that.

I should mention that the kernel was being passed "root=/dev/hda1" as
an option.

-Eric

