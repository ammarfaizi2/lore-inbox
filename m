Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbRCBTEQ>; Fri, 2 Mar 2001 14:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbRCBTEF>; Fri, 2 Mar 2001 14:04:05 -0500
Received: from sparrow.ists.dartmouth.edu ([129.170.249.49]:11925 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S129424AbRCBTD7>; Fri, 2 Mar 2001 14:03:59 -0500
Date: Fri, 2 Mar 2001 14:03:15 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
cc: William Stearns <wstearns@pobox.com>
Subject: [OFFTOPIC] Hardlink utility - reclaim drive space
Message-ID: <Pine.LNX.4.30.0102191626090.29121-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,
	Sorry for the offtopic post; I sincerely believe this will be
useful to developers with multiple copies of, say, the linux kernel tree
on their drives.  I'll be brief.  Please followup to private mail -
thanks.
	Freedups scans the directories you give it for identical files and
hardlinks them together to save drive space.  Please see
ftp://ftp.stearns.org/pub/freedups .  V0.2.1 is up there; it has received
some testing, but may yet contain bugs.
	I was able to recover ~676M by running it against 8 different
2.4.x kernel trees with different patches that originally contained ~948M
of files.  YMMV.
	I do understand there are better ways to handle this problem (cp
-av --link, cvs? Bitkeeper, deleting unneeded trees, tarring up trees,
etc.).  See the readme for a little discussion on this.  This is just one
approach that may be useful in some situations.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Software is largely a service industry operating under the
persistent but unfounded delusion that it is a manufacturing industry."
	-- Eric Raymond
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

