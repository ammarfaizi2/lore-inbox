Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288974AbSA3IMe>; Wed, 30 Jan 2002 03:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288973AbSA3IKr>; Wed, 30 Jan 2002 03:10:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44296 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288969AbSA3IJo>; Wed, 30 Jan 2002 03:09:44 -0500
Date: Wed, 30 Jan 2002 00:09:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Daniel Phillips <phillips@bonn-fries.net>, <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.GSO.4.21.0201300258230.11157-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0201300002170.1542-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Alexander Viro wrote:
> On Wed, 30 Jan 2002, Daniel Phillips wrote:
> > Linus just called you the ext2 maintainer.
>
> Message-ID, please?

I called you the VFS maintainer ("whether you like it or not" I think I
said. Although I can't find the message right now).

Now, that obviously does imply a certain control over low-level
filesystems, but it really mainly implies a control over the _interfaces_
used to talk the the filesystem, not the filesystem itself.

I personally really wouldn't mind seeing most filesystem patches coming
through Al (and, in fact, in the inode trimming patches that is partly
what as been happening), but I have this nagging suspicion that some
filesystem maintainers would rather eat barbed wire (*).

		Linus

(*) The discussions between Gooch and Al are always "interesting", to name
some names.

