Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130129AbRBZDMX>; Sun, 25 Feb 2001 22:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130131AbRBZDMN>; Sun, 25 Feb 2001 22:12:13 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:26230 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S130129AbRBZDL6>;
	Sun, 25 Feb 2001 22:11:58 -0500
Message-ID: <20010226041156.A16707@win.tue.nl>
Date: Mon, 26 Feb 2001 04:11:56 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        "Andreas Jellinghaus" <aj@dungeon.inka.de>,
        <linux-kernel@vger.kernel.org>
Cc: aeb@cwi.nl
Subject: Re: partition table: chs question
In-Reply-To: <20010225163534.A12566@dungeon.inka.de> <20010225224729.A16353@win.tue.nl> <002201c09f87$5ce75640$f6976dcf@nwfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <002201c09f87$5ce75640$f6976dcf@nwfs>; from Jeff V. Merkey on Sun, Feb 25, 2001 at 05:02:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 05:02:09PM -0700, Jeff V. Merkey wrote:

> Please also check vger.timpanogas.org/nwfs/nwfs.tar.gz:disk.c for NetWare
> specific calculations of the CHS values, a different method is used for
> NetWare partitions vs. everything else (Novell just had to be different).

> > On Sun, Feb 25, 2001 at 04:35:34PM +0100, Andreas Jellinghaus wrote:
> >
> > > for partitions not in the first 8gb of a harddisk, what
> > > should the c/h/s start and end value be ?
> > >
> > > most fdisks seem to set start and end to 255/63/1023.
> > > but partition magic creates partitions with start set to
> > > 0/1/1023 and end set to 255/63/1023, and detects a problem
> > > if start is set to 255/63/1023.

Good. I added this to
http://www.win.tue.nl/~aeb/partitions/partition_types-2.html#above1024chs

Now that I looked at this disk.c anyway: it has a table of
partition types, and it seems I collect these.
(See http://www.win.tue.nl/~aeb/partitions/partition_types-1.html )
Are types 57 and 77, labeled "VNDI Partition", actually in use?

Andries
