Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266822AbRGKWLP>; Wed, 11 Jul 2001 18:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266816AbRGKWKz>; Wed, 11 Jul 2001 18:10:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:527 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S266806AbRGKWKp>;
	Wed, 11 Jul 2001 18:10:45 -0400
Date: Wed, 11 Jul 2001 19:10:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Shawn Veader <shawn.veader@zapmedia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: disk full or not?  you decide...
In-Reply-To: <200107112016.f6BKGgVq009480@webber.adilger.int>
Message-ID: <Pine.LNX.4.33L.0107111909140.9899-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Andreas Dilger wrote:

> Note also that on reiserfs, if you have such a process which keeps
> files open after they are deleted and then you have a crash, the file
> is "orphaned" and the space is "lost" until you run reiserfsck again.
> It may be that Chris Mason's patch for this is in the latest kernels,
> but it may not be, and it might not be in the kernel you are running.

Chris, Hans,  is this problem still in the reiserfs
in the current kernel or has it already been fixed ?

If it's still there, is a patch available which can
be considered stable ?

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

