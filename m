Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289916AbSAKJgq>; Fri, 11 Jan 2002 04:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289914AbSAKJga>; Fri, 11 Jan 2002 04:36:30 -0500
Received: from ns2.generalbroadband.com ([64.32.62.5]:9225 "EHLO
	mx1.relaypoint.net") by vger.kernel.org with ESMTP
	id <S289908AbSAKJgY>; Fri, 11 Jan 2002 04:36:24 -0500
Message-ID: <3C3EB274.B227D256@laposte.net>
Date: Fri, 11 Jan 2002 01:37:56 -0800
From: Mike <m.mohr@laposte.net>
X-Mailer: Mozilla 4.51 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.5.[0&1] solved
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all:

Thank you all for your outpouring of helpful hints.  Jens pointed it out
to me first:  I had the wrong processor type selected.  I went into the
kernel config, changed the processor type to 386, and recompiled. 
Rebooting with a newly minted kernel floppy set to mount my primary
partition as its root device, I found that it loaded the kernel and gave
me little trouble that couldn't be fixed with symlinks.  Yes, I know
that odd numbered kernels are bleeding edge releases and as such should
not be used as your primary boot method; this was more for a learning
experience than to get the latest kernel.  I think that I might possibly
patch my new kernel to the very latest bleeding edge, recompile and try
to do it again.  This has been fun!

I'd like to try to help you guys out if I can, so I will submit a bug
report to you now, if this is such: upon shutdown after booting with
2.5.1, the system fails to unmount all filesystems, forcing me to shut
off the power manually.  Upon reboot, fsck finds 4 or 5 errors with my
root partition, but thats to be expecte when you shut down that way
anyhow.  If there is any further info I can give you to help you guys
out, please email me.

Michael Mohr
