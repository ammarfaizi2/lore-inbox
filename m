Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSK0NVY>; Wed, 27 Nov 2002 08:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSK0NVY>; Wed, 27 Nov 2002 08:21:24 -0500
Received: from jrt.me.vt.edu ([128.173.188.212]:20100 "HELO jrt.me.vt.edu")
	by vger.kernel.org with SMTP id <S262486AbSK0NVX>;
	Wed, 27 Nov 2002 08:21:23 -0500
Date: Wed, 27 Nov 2002 09:28:06 -0500 (EST)
From: Clemmitt Sigler <siglercm@jrt.me.vt.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Alan Cox <Alan.Cox@linux.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
In-Reply-To: <20021127125547.GA7903@think.thunk.org>
Message-ID: <Pine.LNX.4.33L2.0211270923260.2368-100000@jrt.me.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Nov 2002, Theodore Ts'o wrote:
> What version of e2fsprogs were you using?  If it was 1.28, that would
> explain what you saw.  There was a fencepost error that could corrupt
> directories when it was optimizing/rehashing them.

I'm using Debian Testing, which is (the maintainer's own?) version
1.29+1.30-WIP-0930-1.  Debian Unstable is now on version 1.32 (and
Testing should get updated to this soon?).  Mind you, what I have
installed is almost 2 months old.

Just in case, I'll upgrade to 1.32 before I try to duplicate the
problem on 2.4.20.  Thanks for your time and trouble :^)

					Clemmitt Sigler

