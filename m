Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129684AbRBBMdy>; Fri, 2 Feb 2001 07:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbRBBMdo>; Fri, 2 Feb 2001 07:33:44 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64005 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129736AbRBBMda>; Fri, 2 Feb 2001 07:33:30 -0500
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
To: kas@informatics.muni.cz (Jan Kasprzak)
Date: Fri, 2 Feb 2001 12:34:19 +0000 (GMT)
Cc: reiser@namesys.com (Hans Reiser), linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
In-Reply-To: <20010202131623.A6082@informatics.muni.cz> from "Jan Kasprzak" at Feb 02, 2001 01:16:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OfPx-0006Pq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hans Reiser wrote:
> : This is why our next patch will detect the use of gcc 2.96, and complain, in the
> : reiserfs Makefile.
> : 
> 	OK, thanks. It works with older compiler (altough I use gcc 2.96
> for a long time for compiling various 2.[34] kernels without problem).

Ok which 2.96 compiler do you have. I need to get this one chased down since
its probably also going to be in the current gcc CVS branches heading for 3.0

2.96-69 should be ok (thats the one I've been using without trouble). The 
original one with RH 7.0 off the CD does miscompile a few kernel things.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
