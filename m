Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287676AbSBCT7E>; Sun, 3 Feb 2002 14:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287681AbSBCT6z>; Sun, 3 Feb 2002 14:58:55 -0500
Received: from mail.tcb.net.au ([210.9.195.45]:49412 "EHLO mail.impulse.net.au")
	by vger.kernel.org with ESMTP id <S287676AbSBCT6k>;
	Sun, 3 Feb 2002 14:58:40 -0500
Date: Mon, 4 Feb 2002 06:57:12 +1100
From: Ben Ryan <ben@bssc.edu.au>
X-Mailer: The Bat! (v1.53d) UNREG / CD5BF9353B3B7091
Reply-To: Ben Ryan <ben@bssc.edu.au>
X-Priority: 3 (Normal)
Message-ID: <175147695064.20020204065712@bssc.edu.au>
To: linux-kernel@vger.kernel.org
CC: Eberhard Moenkeberg <emoenke@gwdg.de>
Subject: compile failed: sbpcd.c under 2.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


greets 'n stuph,

compiling clean from 2.5.2 tarball, inclusion of sbpcd driver broke the compile.
saw mention of a problem with sbpcd a fair while ago, didn't find a resolution to it.
is this a known bug? is there a patch available, or in the pipeline?
looks straightforward, well, to somebody that can code, and that isn't myself ;)



..

sbpcd.c: In function `sbpcd_end_request':
sbpcd.c:4890: structure has no member named `queue'
sbpcd.c: In function named `sbpcd_init':
sbpcd.c:5867: too few arguments to function `blk_init_queue'
        ..69: warning: assignment from incompatible pointer type
        ..70: warning: assignment from incompatible pointer type
        ..71: warning: assignment from incompatible pointer type
sbpcd.c:5925: incompatible types in assignment
make[3]: *** [sbpcd.o] Error 1

..






thanks
ben

