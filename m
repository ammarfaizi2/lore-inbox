Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSDOUWZ>; Mon, 15 Apr 2002 16:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313205AbSDOUWX>; Mon, 15 Apr 2002 16:22:23 -0400
Received: from [195.39.17.254] ([195.39.17.254]:15244 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313202AbSDOUVt>;
	Mon, 15 Apr 2002 16:21:49 -0400
Date: Mon, 8 Apr 2002 20:34:21 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Dominik Kubla <kubla@sciobyte.de>,
        "Alexis S. L. Carvalho" <alexis@cecm.usp.br>,
        linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020408203421.A540@toy.ucw.cz>
In-Reply-To: <20020410092807.GA4015@duron.intern.kubla.de> <200204101807.g3AI79Q46938@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm just tired of this: "Back when I used to use Linux 2.1.44 my
> disks were trashed so bad that I lost everything! So use BSD."
> Last time I checked, BSD fsck didn't have a set of regression tests
> like ext2 fsck does. On the BSD mailing lists you can read about
> fsck getting signal 11. So it's not God's Glorious Filesystem by
> any means.

Actually, I believe I can make current e2fsck mark filesystem clean when
it is not [by trashing disk badly and killing lost+found]. If you can mail
me recent [static] e2fsck, I can test it and create image where it fails.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

