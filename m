Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbTBDU4H>; Tue, 4 Feb 2003 15:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbTBDU4H>; Tue, 4 Feb 2003 15:56:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:36266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267345AbTBDU4G>;
	Tue, 4 Feb 2003 15:56:06 -0500
Date: Tue, 4 Feb 2003 13:03:57 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: cleanup of filesystems menu
In-Reply-To: <Pine.LNX.4.44.0302041512090.16603-100000@dell>
Message-ID: <Pine.LNX.4.33L2.0302041302420.6174-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Robert P. J. Day wrote:

|
|   randy dunlap was gracious enough to post my proposed
| patch to clean up the filesystems config menu.  the patch
| (80K uncompressed) is online at;
|
|   http://www.xenotime.net/linux/kconfig/kconfig-fs-2.5.59b.patch
|
| currently, it still has leading asterisks in front of the
| config entries to support editing in emacs outline mode,
| but future patches will have these removed.
|
|   it should patch cleanly against stock 2.5.59.
|
|   comments?


Here are my comments on the filesystem menu:

That "FS_POSIX_ACL" line is very odd.
What can be done about/with it?

Quota and Automounter:  are they filesystems?
I know, you didn't change that.
Anyway, they are more like FS options or tools.

I would put the list under "Miscellaneous filesystems"
in alphabetical order.

Did you modify "Network File Systems" or "Partition Types"?
Anyway, they are sort of in historical order and I would
put them in alpha order too unless there's some
compelling reason not to do that.

-- 
~Randy

