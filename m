Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSCKVRS>; Mon, 11 Mar 2002 16:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSCKVRJ>; Mon, 11 Mar 2002 16:17:09 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:38662 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290713AbSCKVRG>;
	Mon, 11 Mar 2002 16:17:06 -0500
Date: Mon, 11 Mar 2002 18:11:09 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <20020310202745.GB173@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L.0203111808550.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2002, Pavel Machek wrote:

> > > The problem I find is that I often want to take (file1+patch) -> file2,
> > > when I don't have file1.  But merge tools want to take (file1|file2) -> file3.
> > > I haven't seen a graphical tool which helps you to wiggle a patch into
> > > a file.

> > I often run "patch" and it drops some chunk because it doesn't match,
> > and it turns out that the miss-match is just one or two lines in a
> > chunk that could be very big.

> Yes, this would be [: very very :] nice.

Have you people heard about this thing called "branches" ?

- You keep your own code in your own branch.

- You keep Linus's code in a linus branch.

- The patches from Linus always apply to the linus branch.

- You pull Linus's latest updates into your own branch for
  development work, at this point you may need to do some
  merging.  Some SCM systems are horrible at merging (CVS)
  while others are really nice (BK).

No need to (badly) reinvent the wheel, all of this stuff has
been solved for many years now.

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

