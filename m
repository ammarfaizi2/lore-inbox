Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbTCFGJF>; Thu, 6 Mar 2003 01:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267835AbTCFGJF>; Thu, 6 Mar 2003 01:09:05 -0500
Received: from air-2.osdl.org ([65.172.181.6]:2470 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267812AbTCFGJE>;
	Thu, 6 Mar 2003 01:09:04 -0500
Message-ID: <33061.4.64.238.61.1046931564.squirrel@www.osdl.org>
Date: Wed, 5 Mar 2003 22:19:24 -0800 (PST)
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <aia21@cantab.net>
In-Reply-To: <Pine.SOL.3.96.1030305185900.17585B-100000@libra.cus.cam.ac.uk>
References: <32979.4.64.238.61.1046569101.squirrel@www.osdl.org>
        <Pine.SOL.3.96.1030305185900.17585B-100000@libra.cus.cam.ac.uk>
X-Priority: 3
Importance: Normal
Cc: <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Randy,
>
> Could you try to turn on debugging in the NTFS driver (compile option in the
> menus), then once ntfs module is loaded (or otherwise anytime) as root do:
>
> echo -1 > /proc/sys/fs/ntfs-debug
>
> Then mount and to the directory changes. Assuming that you get the bug again
> could you send me the captured kernel log output? (Note there will be
> massive amounts of output.)
>
> The code looks ok and I can't reproduce here so it would be helpful to see
> if there are any oddities on your partition. Just to make sure it is not the
> compiler, could you do a "make fs/ntfs/inode.S" and send me that as well?
>
> Thanks,

Anton,

I'll get to this in another day or so.

The help text for NTFS_DEBUG says to use 1 to enable it
or 0 to disable it.  What does -1 do?

Thanks,
~Randy



