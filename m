Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262456AbSJET1X>; Sat, 5 Oct 2002 15:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSJET1X>; Sat, 5 Oct 2002 15:27:23 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:36113
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262456AbSJET1W>; Sat, 5 Oct 2002 15:27:22 -0400
Date: Sat, 5 Oct 2002 12:30:18 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Allan Duncan <allan.d@bigpond.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 etc and IDE HDisk geometry
In-Reply-To: <20021004215049.GA20192@win.tue.nl>
Message-ID: <Pine.LNX.4.10.10210051228080.21833-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andries,

If CHS is truly meaningless (less drives smaller than 8.4GB) why can we
not specify forced LBA geometry reporting?  Also any drive supporting
48-bit feature sets are forbidden to use CHS.

Just a comment, not bait for a lesson or lecture :-)


On Fri, 4 Oct 2002, Andries Brouwer wrote:

> On Fri, Oct 04, 2002 at 11:47:16PM +1000, Allan Duncan wrote:
> 
> > Question is - what is determining that initial value that becomes the "logical"
> > CHS, and does it matter?
> 
> No, it does not matter at all.
> CHS are meaningless numbers not used anywhere anymore in Linux.
> 
> If you want to influence what geometry *fdisk will use, give it
> the appropriate options or commands. No need to go via the kernel.
> But only in rare cases is it necessary to worry about geometry.
> 
> Andries
> 
> > Aside - RedHat has dropped cfdisk from util-linux in their distro versions 7.2 ff.
> > Given the bad words said about fdisk, what did cfdisk do to be ostracised?
> 
> RedHat thought cfdisk is buggy.
> They were mistaken.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

