Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268327AbTCFUOk>; Thu, 6 Mar 2003 15:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268295AbTCFUOj>; Thu, 6 Mar 2003 15:14:39 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:17260 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S268327AbTCFUOg>; Thu, 6 Mar 2003 15:14:36 -0500
Date: Thu, 6 Mar 2003 21:15:35 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <aia21@cantab.net>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <Pine.LNX.4.30.0303062035390.31029-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.30.0303062101570.31029-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Szakacsits Szabolcs wrote:
> On Thu, 6 Mar 2003, Randy.Dunlap wrote:
> > I must have missed something here.  What other 2 oopses are you
> > referring to?
>
> Quoting from your report:
>
> ==> Mar  1 13:35:44 midway kernel: Oops: 0002
>
> This means oops counter is 2. So there were two oopses before with
> counter value 0 and 1.

I just checked, this is not true (I could dig up the false source
of information if interested). It's error_code: no page found,
kernel-mode write fault. Sorry for the confusion :(

> > As for closing bug reports because they are not reproducible...
>
> No. Not because it's not reproducible however because it's untrustable
> and bogus. Unless as I mentioned before ... please see above. Thanks!

So this is also invalid ... Could you please send the 'objdump -S
fs/ntfs/inode.o' output? The __ntfs_init_inode part would be enough
also.

	Szaka

