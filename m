Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131236AbRCUPZb>; Wed, 21 Mar 2001 10:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbRCUPZV>; Wed, 21 Mar 2001 10:25:21 -0500
Received: from viper.haque.net ([64.0.249.226]:2695 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S131236AbRCUPZQ>;
	Wed, 21 Mar 2001 10:25:16 -0500
Date: Wed, 21 Mar 2001 10:24:36 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: <linux-kernel@vger.kernel.org>
Subject: ext2_unlink fun
Message-ID: <Pine.LNX.4.32.0103211016570.15278-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine locked hard last night for an unknown reason under
2.4.3-pre4. Rebooted and it did it's fsck thing. Got alot of errors
about missing '..', fixed alot of things and moved some stuff to
/lost+found.

Some files got screwed up so I can't delete them.

[mhaque@viper html-blah]$ rm -r mac3dfx/
rm: cannot remove `mac3dfx/news/1999/08/199908231702.txt': Input/output
error
rm: cannot remove `mac3dfx/news/1999/08/199908231802.txt': Input/output
error
rm: cannot remove directory `mac3dfx/news/1999/08': Directory not empty
rm: cannot remove directory `mac3dfx/news/1999': Directory not empty
rm: cannot remove directory `mac3dfx/news': Directory not empty
rm: cannot remove `mac3dfx/dat': Input/output error
rm: cannot remove directory `mac3dfx': Directory not empty

My filesystem is probably really screwed up so I'm going to format. But
for future reference, how would one get rid of those files? Or does this
indicate that it's time to reformat and not even consider trying to
delete those files?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

