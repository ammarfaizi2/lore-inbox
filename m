Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130519AbRCPPZV>; Fri, 16 Mar 2001 10:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130521AbRCPPZL>; Fri, 16 Mar 2001 10:25:11 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:45064 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S130519AbRCPPYz>; Fri, 16 Mar 2001 10:24:55 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256A11.005489D0.00@smtpnotes.altec.com>
Date: Fri, 16 Mar 2001 09:23:19 -0600
Subject: How to mount /proc/sys/fs/binfmt_misc ?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



OK, I've been struggling with this (off and on) since Tuesday, and I give up.
Since going from 2.4.3-pre4 to 2.4.2-ac20 I have been unable to use binfmt_misc.
Thanks to a hint from Michael Meissner, I found a mention in the release notes
for 2.4.2-ac12 that binfmt_misc should be mounted separately.  However, I still
have a problem.

  The release notes specify this:

     mount -t binfmt_misc none /proc/sys/fs/binfmt_misc

but this doesn't work because

     mount: mount point /proc/sys/fs/binfmt_misc does not exist

And if I try to mkdir -p /proc/sys/fs/binfmt_misc with /proc mounted I get

     mkdir: cannot create directory `/proc/sys/fs/binfmt_misc': No such file or
directory

which makes sense, I guess, because proc isn't a "real" filesystem.  So how do I
get binfmt_misc mounted?

Wayne


