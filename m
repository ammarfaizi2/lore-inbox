Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160230AbQFNXRb>; Wed, 14 Jun 2000 19:17:31 -0400
Received: by vger.rutgers.edu id <S160219AbQFNXMj>; Wed, 14 Jun 2000 19:12:39 -0400
Received: from ix.netcorps.com ([207.1.125.106]:47621 "EHLO ix.netcorps.com") by vger.rutgers.edu with ESMTP id <S160224AbQFNXLi>; Wed, 14 Jun 2000 19:11:38 -0400
Message-ID: <39481130.34C9918E@timpanogas.com>
Date: Wed, 14 Jun 2000 17:11:44 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.com>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: benr@us.ibm.com
Cc: linux-lvm@msede.com, linux-kernel@vger.rutgers.edu, linux-fsdevel@vger.rutgers.edu, reiser@idiom.com, sbest@us.ibm.com, peloquin@us.ibm.com, andrea@suse.de, okeefe@sistina.com, wiegand@suse.de, "Stephen C. Tweedie" <sct@redhat.com>, venditti@us.ibm.com, Mauelshagen@sistina.com
Subject: Re: IBM to release LVM Technology to the Linux Community
References: <852568FE.00750CE1.00@d54mta02.raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu


Ben,

You may want to contact Jeff Magdahl in NY regarding what we are doing
to allow IBM to migrate NetWare volumes and NDS data to the S/390 to
support server consolidation of NetWare servers onto S/390 host systems,
and let us know if we should be using your LVM code.  We are porting
intially to 3000-P30 S/390 systems all of our NetWare to Linux migration
tools to support large scale Migrations of NetWare servers onto IBM
based hosts that run Linux and VM, MVS, etc..  

The LVM approach will be useful, but at present won't support NDS to
S/390 migration without some mechanism to grant access to the NDS data
sets (which we provide).  It appears, however, that IBM's contracts with
Novell are loose enough to allow IBM to use the NDS for S/390 code base
it got fom Novell to create some custom tools to import NDS data sets
into VM and MVS (at present, NDS is only available on MVS for migration,
and it's not implemented to exploit this currently).  

At any rate, we will look at the LVM stuff to see if it will help with
NetWare to Linux migrations on S/390.  Thanks for helping Linux.  Let us
know if there's anything we can do to assist IBM in migrating Novell's
installed base to Linux on S/390.  We are happy to help those who help
Linux.

Very Truly Yours,

Jeff Merkey
CEO, TRG


benr@us.ibm.com wrote:
> 
> Hello!
> 
> Since IBM has begun to publicly support Linux, many of our customers have
> started showing an interest in Linux.  We have received many requests from
> our customers asking us to enhance certain areas of Linux (logical volume
> management in particular) in order to make Linux a more acceptable platform
> for their IT operations.  Furthermore, we have been asked to provide a
> migration path from existing platforms (both IBM and non-IBM) to Linux.
> IBM has been moving to satisfy these requests by contributing developers
> and technology to the Linux Community.  This is what drove IBM's decision
> to release JFS to the Linux Community, and it  is driving the decision to
> release logical volume management technology to the Linux Community.
> 
> IBM is releasing one of its most advanced architectures for a Logical
> Volume Management System.  This architecture is quite interesting as it
> completely integrates all disk and volume management into a single, highly
> extensible, easy to use entity.  We hope that the release of this
> technology will lead to a world class logical volume management system for
> Linux, one which satisfies the requirements of our customers as well as
> those of the Linux Community.
> 
> The first of several white papers describing the LVMS architecture can be
> found at the IBM Linux Technology Center website:
> 
> http://oss.software.ibm.com/developerworks/opensource/linux/
> 
> Since we would like to have an honest, open discussion about this, I would
> suggest that all interested parties post their comments to the LVM mailing
> list (unless someone has a better suggestion!).  All comments are welcome!
> 
> Thanks!
> 
> Ben Rafanello
> IBM Linux Technology Center
> 
> PS - Information about the LVM mailing list can be found at:
> http://linux.msede.com/lvm/mlist/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
