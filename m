Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263343AbSJFFAX>; Sun, 6 Oct 2002 01:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263344AbSJFFAX>; Sun, 6 Oct 2002 01:00:23 -0400
Received: from adsl-66-136-198-157.dsl.austtx.swbell.net ([66.136.198.157]:3714
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S263343AbSJFFAV>; Sun, 6 Oct 2002 01:00:21 -0400
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Michael Clark <michael@metaparadigm.com>
Cc: Shawn <core@enodev.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Andreas Dilger <adilger@clusterfs.com>,
       Lars Marowsky-Bree <lmb@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D9C6099.9060504@metaparadigm.com>
References: <Pine.GSO.4.21.0210021922200.13480-100000@weyl.math.psu.edu>
	 <3D9BDA8D.5080700@metaparadigm.com>
	 <1033648730.28022.8.camel@irongate.swansea.linux.org.uk>
	 <3D9C4FA8.10201@metaparadigm.com> <20021003100702.C32461@q.mn.rr.com>
	 <3D9C6099.9060504@metaparadigm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1033880752.6387.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 06 Oct 2002 00:05:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 10:22, Michael Clark wrote:
> On 10/03/02 23:07, Shawn wrote:
> > On 10/03, Michael Clark said something like:
> > 
> >>On 10/03/02 20:38, Alan Cox wrote:
> >>
> >>>On Thu, 2002-10-03 at 06:50, Michael Clark wrote:
> >>>
> >>>
> >>>>>... and you don't need EVMS for that.
> >>>>
> >>>>But EVMS would be an excellent substitute in the mean time.
> >>>>
> >>>>Better to having something excellent now than something perfect but
> >>>>too late.
> >>>
> > 
> > This statement is misleading; in no way is EVMS intended as an
> > interim solution to a problem addressed easier in other ways. It's
> > a fundamental change which happens to address certain critical issues
> > and also adds functionality whiz-bangs.
> 
> Yes, i agree. It's not the original intention of EVMS to be used
> as a unified interface to all linux block devices. Although it
> could be used in that way if desired by any individual user -
> to provide a solution to the consistent block device naming issue.

This is true, but the major problem comes of upgrading and compatibility
issues with old versions of LVM, etc. The usual stuff, IMHO. 

> >>>You can see who around here has maintained kernel code and who hasnt.
> >>>You don't want a substitute in the mean time, because then you have to
> >>>get rid of it
> >>
> >>Like LVM ;)
> > 
> > 
> > Not quite...
> 
> Well, existing LVM does appear to be a subsitute for a better solution
> (dm or EVMS) for which it's time has come to be removed.


I'm not sure what you're saying here. EVMS is good, but I believe that
LVM and EVMS serve two different purposes, mainly with regard to the
type of environments each is used in. 

I've attempted to contact Heinz twice, I hope he responds about this
soon. I like LVM for it's simplicity, and ease of use. Simple tools, and
methods that get the job done. 

> ~mc
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
