Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267514AbRGNCEa>; Fri, 13 Jul 2001 22:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267518AbRGNCES>; Fri, 13 Jul 2001 22:04:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:36362 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267514AbRGNCEC>; Fri, 13 Jul 2001 22:04:02 -0400
Date: Fri, 13 Jul 2001 19:03:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Abramo Bagnara <abramo@alsa-project.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        <nfs-devel@linux.kernel.org>, <nfs@lists.sourceforge.net>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: [NFS] [PATCH] Bug in NFS - should init be allowed to set umask???
In-Reply-To: <15183.31372.316080.1208@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.33.0107131902420.1431-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 14 Jul 2001, Neil Brown wrote:
>
> I've found a 4th option.  We make it so that fs->umask does not affect
> nfsd

Me likee.

Applied. I'd only like to double-check that you made sure you changed all
callers?

		Linus

