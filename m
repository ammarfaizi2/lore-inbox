Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbSJAH5N>; Tue, 1 Oct 2002 03:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbSJAH5N>; Tue, 1 Oct 2002 03:57:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57616 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261517AbSJAH5M>; Tue, 1 Oct 2002 03:57:12 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Date: Tue, 1 Oct 2002 08:04:29 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <anbkud$q5e$1@penguin.transmeta.com>
References: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com> <200210010939.53707.devilkin-lkml@blindguardian.org>
X-Trace: palladium.transmeta.com 1033459327 6295 127.0.0.1 (1 Oct 2002 08:02:07 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Oct 2002 08:02:07 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200210010939.53707.devilkin-lkml@blindguardian.org>,
DevilKin  <devilkin-lkml@blindguardian.org> wrote:
>
>Basically: I would _love_ to test this kernel on my laptop here, but - 
>unfortunately - i need the laptop for my work. Which means i need it to work.
>
>So how much chance IS there to trash the filesystems? I guess a lot of ppl 
>like me are just waiting to test it out, but aren't willing to screw their 
>systems over it...

Personal opinion (and only that): not much chance for a filesystem
trashing. 

There's more chance of something just not _working_ than of disk
corruption.  Ie you may find that some driver you need doesn't compile
because it hasn't been updated to the new world order yet, for example. 

And people still report problems booting, for example, whatever the
reason. So make sure you have a working choice in your lilo
configuration or whatever.

But from what we've seen lately, there really aren't reports of
corrupted disks or anything like that that I've seen.  Which is
obviously not to say that it couldn't happen, but it's not a very likely
occurrence. 

That said, I can't set other peoples risk bars for them.

		Linus
