Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135516AbRD3SgU>; Mon, 30 Apr 2001 14:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135513AbRD3SgF>; Mon, 30 Apr 2001 14:36:05 -0400
Received: from adsl-208-190-203-202.dsl.kscymo.swbell.net ([208.190.203.202]:41129
	"HELO sbox.labfire.com") by vger.kernel.org with SMTP
	id <S135516AbRD3Ser>; Mon, 30 Apr 2001 14:34:47 -0400
Date: Mon, 30 Apr 2001 13:34:41 -0500
From: Ian Wehrman <ian@labfire.com>
To: Rob Todd <todd@hcs.ufl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: continued ext2fs corruption
Message-ID: <20010430133441.A15828@labfire.com>
Reply-To: ian@labfire.com
In-Reply-To: <20010430093507.A11567@labfire.com> <JEEMLFOHKBAGMJGMHBIOEEANCAAA.todd@hcs.ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <JEEMLFOHKBAGMJGMHBIOEEANCAAA.todd@hcs.ufl.edu>; from todd@hcs.ufl.edu on Mon, Apr 30, 2001 at 11:26:05AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Todd <todd@hcs.ufl.edu> wrote:
> I am using RH 7.1 with the stock 2.4.2-2 kernel (although the same behavior
> shows up in 2.4.4 also compiled using gcc 2.96).  Not quite sure about
> hardware we share... it is a 1GHz P3 ServerWorks LE board (with the OSB4
> chipset) connecting to a Seagate ST320414A 20GB HD (UDMA 33).  We have
> several hundred other machines (including older ServerWorks boards) running
> 2.4.4 with no problem so I was extremely surprised to receive these 32
> machines and have every single one of them experience some sort of file
> system corruption.  I am running 2.2.19 right now on these 32 machines with
> no problems whatsoever.
> 
> Rob Todd <todd@hcs.ufl.edu> wrote:
> > If you receive an answer please let me know... I've been seeing the same
> > problems on a 1GHz P3 with a ServerWorks OSB4 chipset.

on the surface, it looks like your systems don't have anything in common with
mine. i'm running rh71 too, but that's only because running kernel 2.4.2 on my
previous rh62 system corrupted the filesystem so badly that i had to format
and reinstall. i admit i'm somewhat glad to hear i'm not the only one having
these problems, but it obviously isn't particularly widespread. are you also
getting errors like this:

EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
#508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
name_len=0 

the disk that becomes corrupted for me is an IBM Deskstar (UDMA 33), and it's on
an intel 440BX chipset. does anyone here have any thoughts?

thanks,
ian
