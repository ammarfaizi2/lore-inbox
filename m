Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSGZJAj>; Fri, 26 Jul 2002 05:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSGZJAj>; Fri, 26 Jul 2002 05:00:39 -0400
Received: from p3EE3E50F.dip.t-dialin.net ([62.227.229.15]:22532 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S317398AbSGZJAh>;
	Fri, 26 Jul 2002 05:00:37 -0400
Date: Fri, 26 Jul 2002 10:52:40 +0200
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: linux-kernel@vger.kernel.org
Cc: mge@sistina.com
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020726105240.A11942@sistina.com>
Reply-To: mauelshagen@sistina.com
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com> <1027199147.16819.39.camel@irongate.swansea.linux.org.uk> <1027197028.26159.2.camel@UberGeek.digitalroadkill.net> <20020720205520.GX29001@khan.acc.umu.se> <20020720212414.GL10315@clusterfs.com> <1027211042.16819.45.camel@irongate.swansea.linux.org.uk> <20020721014714.GM10315@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020721014714.GM10315@clusterfs.com>; from adilger@clusterfs.com on Sat, Jul 20, 2002 at 07:47:14PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2002 at 07:47:14PM -0600, Andreas Dilger wrote:
> On Jul 21, 2002  01:24 +0100, Alan Cox wrote:
> > On Sat, 2002-07-20 at 22:24, Andreas Dilger wrote:
> > > I, for one, would like to have the choice to use the AIX LVM format, and
> > > I'm sure that people thinking of migrating from HP/UX or whatever would
> > > want to be able to add support for their on-disk LVM format.  It really
> > > provides a framework to consolidate all of the partition/MD code into
> > > a single place (e.g. RAID, LVM, LDM (windows NT), DOS, BSD, Sun, etc).
> > 
> > The LVM format for AIX and so on call all be handled by LVM2
> 
> Can it also do mirroring and RAID?  One of the features of AIX LVM is
> mirroring on a per-PE basis.  If LVM2 can do this, then great.

We have the mirroring target in device-mapper already working to do pvmove sane
shortly. Tool support for mirroring will follow in fall. The generic design
of device-mapper keeps it completely to the tools if you like per-PE mirroring.

> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> http://sourceforge.net/projects/ext2resize/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
