Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSHGJ5q>; Wed, 7 Aug 2002 05:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSHGJ5q>; Wed, 7 Aug 2002 05:57:46 -0400
Received: from ns.suse.de ([213.95.15.193]:64523 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317083AbSHGJ5p>;
	Wed, 7 Aug 2002 05:57:45 -0400
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre1
References: <200208062329.g76NTqP30962@devserv.devel.redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Aug 2002 12:01:24 +0200
In-Reply-To: Alan Cox's message of "7 Aug 2002 01:35:54 +0200"
Message-ID: <p73vg6nhtsb.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> 	- Remove mess where x86_64 sticks its arse in all sorts of
> 	  config files and makes a mess of it. Other ports done because
> 	  the result sucks, x86_64 shouldnt either

Can you explain this further. How else do you propose to get rid of 
unmaintained-and-absolutely-hopeless-on-64bit drivers in the configuration? 
I definitely do not want to get bug reports about these not working on x86-64.

If you think CONFIG_X86_64 is too ugly, perhaps an generic CONFIG_64BIT would 
be preferable for you? I personally would prefer CONFIG_UNMAINTAINED_AND_BROKEN and telling users they are on their own when they enable it, but that is 
probably just me.

> 	- Drop utterly bogus change todrivers/sound/Config.in

Given that one was bogus. Must have been a merge mistake on my part.

-Andi

