Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278125AbRKFHCH>; Tue, 6 Nov 2001 02:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278218AbRKFHB5>; Tue, 6 Nov 2001 02:01:57 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:36284 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S278125AbRKFHBr>; Tue, 6 Nov 2001 02:01:47 -0500
Date: Tue, 6 Nov 2001 00:01:43 -0700
Message-Id: <200111060701.fA671hL20646@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: alain@linux.lu, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10 
In-Reply-To: <Pine.GSO.4.21.0110271422520.21545-100000@weyl.math.psu.edu>
In-Reply-To: <200110271800.f9RI0M803440@hitchhiker.org.lu>
	<Pine.GSO.4.21.0110271422520.21545-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 	BTW, here's one more devfs rmmod race: check_disk_changed() in
> fs/devfs/base.c.  Calling ->check_media_change() with no protection
> whatsoever.  If rmmod happens at that point...

How is this different from a call to fs/block_dev.c:check_disk_change()
which also has no protection?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
