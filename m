Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281040AbRKGXBv>; Wed, 7 Nov 2001 18:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281045AbRKGXBk>; Wed, 7 Nov 2001 18:01:40 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:61451 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281040AbRKGXB3>; Wed, 7 Nov 2001 18:01:29 -0500
Message-ID: <3BE9BC12.6E1A6295@zip.com.au>
Date: Wed, 07 Nov 2001 14:56:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
In-Reply-To: <E161Y87-00052r-00@the-village.bc.nu>, <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk> <3BE99650.70AF640E@zip.com.au>, <3BE99650.70AF640E@zip.com.au> <20011107133301.C20245@mikef-linux.matchmail.com> <3BE9AF15.50524856@zip.com.au>,
		<3BE9AF15.50524856@zip.com.au> <20011107142750.A545@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Wed, Nov 07, 2001 at 02:00:53PM -0800, Andrew Morton wrote:
> > Mike Fedyk wrote:
> > >
> > > I have a switch "data=journal" that ext2 will choke on when I boot into an
> > > ext2 only kernel.
> > >
> > > Is there another way to change the journaling mode besides modifying
> > > /etc/fstab?
> >
> > Try  adding `rootflags=data=journal' to your kernel boot
> > commandline.
> >
> 
> Does that work for non-root ext3 mounts also?  ie, will ext3 default to
> data=journaled mode for future mounts?

Nope.  You specify the option to other filesystems in /etc/fstab.
