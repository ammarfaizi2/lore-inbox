Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289330AbSAWWpU>; Wed, 23 Jan 2002 17:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289532AbSAWWpK>; Wed, 23 Jan 2002 17:45:10 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:56588 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S289330AbSAWWpF>;
	Wed, 23 Jan 2002 17:45:05 -0500
Date: Wed, 23 Jan 2002 13:18:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020123121819.GD965@elf.ucw.cz>
In-Reply-To: <a2bk6e$t2u$1@ncc1701.cistron.net> <Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu> <a2bn7g$5hm$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2bn7g$5hm$1@ncc1701.cistron.net>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> This could be hacked around ofcourse in fs/namei.c, so I tried
> >> it for fun. And indeed, with a minor correction it works:
> >> 
> >> % perl flink.pl 
> >> Success.
> >> 
> >> I now have a flink-test2.txt file. That is pretty cool ;)
> >
> >It's also a security hole.
> 
> How is linking back a file into the normal namespace anymore
> a security hole as having it under /proc or keeping an fd to it
> open?

Imagine you want to delete my file, you are root.

Before, you could rm it, then kill all my processes.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
