Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130204AbQK2AGm>; Tue, 28 Nov 2000 19:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130537AbQK2AGc>; Tue, 28 Nov 2000 19:06:32 -0500
Received: from north.net.CSUChico.EDU ([132.241.66.18]:20232 "EHLO
        north.net.csuchico.edu") by vger.kernel.org with ESMTP
        id <S130204AbQK2AGS>; Tue, 28 Nov 2000 19:06:18 -0500
Date: Tue, 28 Nov 2000 15:36:15 -0800
From: John Kennedy <jk@csuchico.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blindingly stupid 2.2 VM bug
Message-ID: <20001128153615.E7323@north.csuchico.edu>
In-Reply-To: <20001119100100.A54301@niksula.cs.hut.fi> <Pine.LNX.4.21.0011201135590.4587-100000@duckman.distro.conectiva> <20001124152831.A5696@valinux.com> <20001125145701.A12719@athlon.random> <20001128150235.A7323@north.csuchico.edu> <20001129002009.I14675@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001129002009.I14675@athlon.random>; from andrea@suse.de on Wed, Nov 29, 2000 at 12:20:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 12:20:09AM +0100, Andrea Arcangeli wrote:
> On Tue, Nov 28, 2000 at 03:02:35PM -0800, John Kennedy wrote:
> > On Sat, Nov 25, 2000 at 02:57:01PM +0100, Andrea Arcangeli wrote:
> > > ... VM-global-*-7 has no known bugs AFIK.
> > 
> >   Is there anything more recent than VM-global-2.2.18pre18-7?  It isn't
> > patching very cleanly against my pre-patch-2.2.18-23 tree. 
> 
> It patches cleanly for me. (ignore the offset warnings from patch, just make
> sure there are no rejects)

  No, it is all ext3fs stuff that is touching the same areas your
patch is.  Sorry.  I was assuming that Rik van Riel's comments implied
that they should get patch a lot more cleanly and that I might have
missed a version, but there is no way these two could patch without
rejects along as-is.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
