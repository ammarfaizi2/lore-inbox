Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312943AbSDDAXF>; Wed, 3 Apr 2002 19:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312964AbSDDAWz>; Wed, 3 Apr 2002 19:22:55 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:21380 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312943AbSDDAWe>; Wed, 3 Apr 2002 19:22:34 -0500
Date: Wed, 3 Apr 2002 17:22:22 -0700
Message-Id: <200204040022.g340MMe14261@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: segher@chello.nl
Cc: Dave Hansen <haveblue@us.ibm.com>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org, Craig Christophel <merlin@transgeek.com>
Subject: Re: [PATCH] shift BKL out of notify_change
In-Reply-To: <3CAB9C68.1A879B4D@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool writes:
> > > -    struct fs_info *fs_info = inode->i_sb->u.generic_sbp;
> > > +    struct fs_info efs_info = inode->i_sb-nu.generic_sbp;
> > 
> > What on earth is this change? Some kind of cut-and-paste error?
> 
> 0x3e --> 0x7e.  Single bit error.  Aieee!

Two bytes have an error, not just one.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
