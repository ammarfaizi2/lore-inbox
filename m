Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbRJKVgi>; Thu, 11 Oct 2001 17:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276966AbRJKVg3>; Thu, 11 Oct 2001 17:36:29 -0400
Received: from ns.caldera.de ([212.34.180.1]:13772 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276956AbRJKVgU>;
	Thu, 11 Oct 2001 17:36:20 -0400
Date: Thu, 11 Oct 2001 23:36:46 +0200
Message-Id: <200110112136.f9BLakI04545@ns.caldera.de>
From: Marcus Meissner <mm@ns.caldera.de>
To: war@starband.net (war), linux-kernel@vger.kernel.org
Subject: Re: Can only login via ssh 1013 times.
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3BC60B59.71F0367A@starband.net>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BC60B59.71F0367A@starband.net> you wrote:
> Before you read this, I just wanted to see how many times I could login.

> I would never need 1000+ users support, but others may need it.

> So I was just curious to see how many times I could login with ssh
> version 1.
> I put in 2048 for the number of ptys allowed for the kernel options,
> recompiled and installed.

> I made a little expect script which would log me in the next time
> I login and so on and so forth.
> After I logged in 1013? times or so it said "you are out of ptys..."

> Once again I have no need for this amount of users, but I was curious,
> how many simultaneous users can be logged on to a linux box at one time?

> I'll guess @ 1024 considering I had some xterm's open.

> Anyone?

You maximum of open files is too low.

Increase the value /proc/sys/fs/file-max (check current usage in file-nr).

Ciao, Marcus
