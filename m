Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274806AbRJJFTc>; Wed, 10 Oct 2001 01:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274803AbRJJFT1>; Wed, 10 Oct 2001 01:19:27 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30100 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S274806AbRJJFSa>; Wed, 10 Oct 2001 01:18:30 -0400
Date: Tue, 9 Oct 2001 23:18:50 -0600
Message-Id: <200110100518.f9A5Io516155@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Matt_Domsch@Dell.com
Cc: adilger@turbolabs.com, torvalds@transmeta.com, alan@redhat.com,
        Martin.Wilck@Fujitsu-Siemens.com, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
Subject: RE: [PATCH] EFI GUID Partition Tables
In-Reply-To: <71714C04806CD51193520090272892178BD6DB@ausxmrr502.us.dell.com>
In-Reply-To: <71714C04806CD51193520090272892178BD6DB@ausxmrr502.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch writes:
> Richard and Andreas, thanks for your feedback.
> > Would it be possible to put this somewhere else and/or rename it?  It
> > appears that GUIDs are really DCE UUIDs (which are used by 
> > other things
> > like ext2, XFS, MD RAID, etc) so if we are "advertising" 
> > UUIDs from the
> > kernel, we may as well make it "sensible" for other users.  How about
> > "/dev/dis[ck]s/uuid", unless there are other users of UUID 
> > identifiers?
> 
> Yes, UUIDs and GUIDs are the same thing, fortunately.
> I'll have to defer this to the author of this piece of code.  Martin, any
> reason why it shouldn't be renamed?  Richard, any preferred name?

I'd prefer /dev/volumes/uuids/
Similarly, if label reading code is added, I'd like to see that put in
/dev/volumes/labels/

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
