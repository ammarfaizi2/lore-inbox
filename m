Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130220AbRBEQ6Q>; Mon, 5 Feb 2001 11:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbRBEQ6G>; Mon, 5 Feb 2001 11:58:06 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:44702 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130220AbRBEQ6B>; Mon, 5 Feb 2001 11:58:01 -0500
Date: Mon, 5 Feb 2001 16:57:21 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Hans Reiser <reiser@namesys.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Brian Wolfe <ahzz@terrabox.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink 
 related)
In-Reply-To: <3A7E904F.797AF09B@namesys.com>
Message-ID: <Pine.SOL.4.21.0102051655420.23304-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Hans Reiser wrote:

> Alan Cox wrote:
> > 
> > > In an __init function, have some code that will trigger the bug.
> > > This can be used to disable Reiserfs if the compiler was bad.
> > > Then the admin gets a printk() and the Reiserfs mount fails.
> > 
> > Thats actually quite doable. I'll see about dropping the test into -ac that
> > way.
> NOOOOO!!!!!! It should NOT fail at mount time, it should fail at compile time.

A simple "make test" to run this sort of automated sanity check would be
good, I think?


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
