Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSBXDFO>; Sat, 23 Feb 2002 22:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289299AbSBXDFF>; Sat, 23 Feb 2002 22:05:05 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:19438
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S289298AbSBXDEv>; Sat, 23 Feb 2002 22:04:51 -0500
Date: Sat, 23 Feb 2002 19:05:28 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Chris Sykes <chris@sykes.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: floppy in 2.4.17
Message-ID: <20020224030528.GQ20060@matchmail.com>
Mail-Followup-To: Chris Sykes <chris@sykes.uklinux.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020223160544.A1905@werewolf.able.es> <20020223184916.GA1518@chiara.cavy.de> <20020223220007.A461@cooper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020223220007.A461@cooper>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 10:00:07PM +0000, Chris Sykes wrote:
> On Sat, Feb 23, 2002 at 07:49:16PM +0100, Heinz Diehl wrote:
> > On Sat Feb 23 2002, J.A. Magallon wrote:
> > 
> > > I am getting problems with floppy drive in 2.4.17.
> > > All started with floppy not working in 18-rc4, went back to 17
> > > and still does not work. Just plain 2.4.17, no patching.
> >  
> > > mkfs -v -t ext2 /dev/fd0 gives:
> >  
> > > mke2fs 1.26 (3-Feb-2002)
> > > mkfs.ext2: bad blocks count - /dev/fd0
> > 
> > Exactly the same thing here.
> 
> Yet another meetoo.
> 
> I also experience hard lockups when writing to the floppy drive (fdformat,
> dd etc.) , nothing in my logs though.
> 

I've seen this a couple times also, but not on the -ac series recently.

I notice this in 2.4.18-pre9-ac1:
o       Fix floppy reservation ranges                   (Anton Altaparmakov)  

So, can you guys stress the -ac patch to see if it's fixed there?

Mike










