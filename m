Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288403AbSADADC>; Thu, 3 Jan 2002 19:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288404AbSADACw>; Thu, 3 Jan 2002 19:02:52 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:20985 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288403AbSADACr>;
	Thu, 3 Jan 2002 19:02:47 -0500
Date: Thu, 3 Jan 2002 17:00:32 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org,
        sak@iki.fi, phillips@innominate.de, viro@math.psu.edu, tao@acc.umu.se
Subject: Re: Ext2 groups descriptor corruption in 2.2 - Phillips's patch seems to work
Message-ID: <20020103170032.H12868@lynx.no>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Ville Herva <vherva@niksula.hut.fi>, linux-kernel@vger.kernel.org,
	sak@iki.fi, phillips@innominate.de, viro@math.psu.edu,
	tao@acc.umu.se
In-Reply-To: <E16LjnL-00010c-00@starship.berlin> <E16LjxJ-0003om-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E16LjxJ-0003om-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 02, 2002 at 11:53:12AM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 02, 2002  11:53 +0000, Alan Cox wrote:
> > Since you have done such a thorough job of documenting the whole thing, why 
> > not drop the other shoe and submit the patches?
> 
> He did 8)
> 
> I've asked him to run them past Stephen and the other ext2 folks

Well, nobody else has spoken up on this, so I might as well.  I remember
when Daniel originally posted this fix, and at the time it was the right
thing to do.  Al's patch fixed more than Daniel's did, but I think it is
too much change to be adding to 2.2, so we should use the minimal fix
from Daniel, unless there are objections.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

