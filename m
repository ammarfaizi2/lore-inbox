Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288529AbSADHrm>; Fri, 4 Jan 2002 02:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288528AbSADHrc>; Fri, 4 Jan 2002 02:47:32 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:16188 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S288527AbSADHrZ>; Fri, 4 Jan 2002 02:47:25 -0500
Date: Fri, 4 Jan 2002 09:36:26 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: adilger@turbolabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org, sak@iki.fi, phillips@innominate.de,
        viro@math.psu.edu, tao@acc.umu.se
Subject: Re: Ext2 groups descriptor corruption in 2.2 - Phillips's patch seems to work
Message-ID: <20020104093626.C1200@niksula.cs.hut.fi>
In-Reply-To: <E16LjnL-00010c-00@starship.berlin> <E16LjxJ-0003om-00@the-village.bc.nu> <20020103170032.H12868@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020103170032.H12868@lynx.no>; from adilger@turbolabs.com on Thu, Jan 03, 2002 at 05:00:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2002 at 05:00:32PM -0700, you [Andreas Dilger] said:
> On Jan 02, 2002  11:53 +0000, Alan Cox wrote:
> > > Since you have done such a thorough job of documenting the whole thing, why 
> > > not drop the other shoe and submit the patches?
> > 
> > He did 8)
> > 
> > I've asked him to run them past Stephen and the other ext2 folks
> 
> Well, nobody else has spoken up on this, so I might as well.  I remember
> when Daniel originally posted this fix, and at the time it was the right
> thing to do.  Al's patch fixed more than Daniel's did,

"More", in what way? Fixed more problem cases or just better in sense that
he refromatted and splitted the long ext2_new_inode() function?

> but I think it is too much change to be adding to 2.2, so we should use
> the minimal fix from Daniel, unless there are objections.

Ok. The minimal approach is what I was after, too :).

Do you have any opionion about 2.0? The problem has been spotted on 2.0.39,
too, and the 2.0.40pre3 ext2_new_inode() is almost identical to 2.2 one
barring few trivialish changes. We plan to test the patch some more on 2.0
(we already know it compiles and boots, btw ;), but it would be nice if some
one who has played with 2.0 ext2 would give a "go ahead".


-- v --

v@iki.fi
