Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132941AbRASQFS>; Fri, 19 Jan 2001 11:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133047AbRASQFJ>; Fri, 19 Jan 2001 11:05:09 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:6148 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S132941AbRASQEv>;
	Fri, 19 Jan 2001 11:04:51 -0500
Message-ID: <3A686599.470272D6@holly-springs.nc.us>
Date: Fri, 19 Jan 2001 11:04:41 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mo McKinlay <mmckinlay@gnu.org>
CC: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <Pine.LNX.4.30.0101191547210.2331-100000@nvws005.nv.london>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mo McKinlay wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Today, Michael Rothwell (rothwell@holly-springs.nc.us) wrote:
> 
>   > The filesystem, when registering that it supports the "named streams"
>   > namespace, could specify its preferred delimiter to the VFS as well.
>   > Ext4 could use /directory/file/stream, and NTFS could use
>   > /directory/file:stream.
> 
> Erk - nice from a programming point of view, horrible from a consistency
> one. The nice thing about VFS is that it provides a consistent abstract
> interface - I'd place a small amount of money on the fact that Al Viro
> would probably flame you to high heaven for that last suggestion if he was
> paying much attention to this thread :-)

Oh, undoubtedly.  But NTFS already disallows several characters in valid
filenames. This also violates the "consistent abstract interface." But
it's reality.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
