Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbSJALQ2>; Tue, 1 Oct 2002 07:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJALQ1>; Tue, 1 Oct 2002 07:16:27 -0400
Received: from irc.sh.nu ([216.239.132.110]:6814 "EHLO fungus.sh.nu")
	by vger.kernel.org with ESMTP id <S261567AbSJALQ0>;
	Tue, 1 Oct 2002 07:16:26 -0400
Date: Tue, 1 Oct 2002 04:21:51 -0700
From: crimsun@fungus.sh.nu
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: New set of code snapshots for ext3-dxdir (kernel and userspace)
Message-ID: <20021001042151.A820@fungus.sh.nu>
References: <E17wELv-00028q-00@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17wELv-00028q-00@think.thunk.org>; from tytso@mit.edu on Tue, Oct 01, 2002 at 12:09:43AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 12:09:43AM -0400, tytso@mit.edu wrote:
[...]
> Anyway, let's try to synchronize on a common set of kernel patches and
> userspace utilities, and see whether or not we've managed to get all of
> the problems fixed.

Sure, I'm willing (backed up my workstation completely, of course). I
first rebuilt 2.4.19 with your new patch applied on a ext3 fs with
dir_index disabled, built your new e2fsprogs WIP packages, and installed
them. Installed the new kernel. Turned on dir_index, and rebooted into
the new kernel.

[...]
> With these code base, and using a freshly created filesystem, I haven't
> been able to reproduce any problems using Ryan's fs-ream.c stress
> tester.  So I'm pretty confident about its stability, although there
> might possibly be some race conditions lurking about under extreme load.

Good news: I haven't been able to replicate any of the corruption I was
seeing earlier with Galeon 1.2.6 and Mozilla 1.1 from Debian's unstable
branch. This corruption would occur pretty randomly but almost
immediately after starting Galeon, and it'd show up immediately in my
xconsole (I use xdm) in the form of some nasty EXT3 errors (as I noted
earlier).

I'll bang away with dump and bonnie[++] and see if I can make it spew.
;-)

Thanks again!

-Dan

-- 
Dan Chen                crimsun@fungus.sh.nu
GPG key:   www.sh.nu/~crimsun/pubkey.gpg.asc
