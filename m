Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278309AbRJ1NLc>; Sun, 28 Oct 2001 08:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278320AbRJ1NLW>; Sun, 28 Oct 2001 08:11:22 -0500
Received: from robin.mail.pas.earthlink.net ([207.217.120.65]:18593 "EHLO
	robin.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S278316AbRJ1NLH>; Sun, 28 Oct 2001 08:11:07 -0500
Date: Sun, 28 Oct 2001 08:13:32 -0500
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: VM test on 2.4.14-pre3aa1 (compared to 2.4.14-pre3)
Message-ID: <20011028081332.A302@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:  2.4.14-pre3aa1 takes more wall time for
	tests.  Audio sounds closer to the "edge",
	I.E more likely to skitter or skip.

Test:	Run "mtest01 -w 80" and mmap001 from LTP.
	Listen to long mp3 sampled at 128k.
	Light console irc client and lynx use.


2.4.14-pre3aa1

About 2-3 seconds of sound skitter when typing
a URL in lynx or something in irc client. 

Averages for 10 mtest01 runs
bytes allocated:                    1246232576
User time (seconds):                2.105
System time (seconds):              2.773
Elapsed (wall clock) time:          59.503
Percent of CPU this job got:        7.80
Major (requiring I/O) page faults:  132.8
Minor (reclaiming a frame) faults:  305043.1

About 2-3 seconds of sound drop on mmap001 for
2.4.14-pre3aa1. 

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.660
System time (seconds):              16.272
Elapsed (wall clock seconds) time:  287.13
Percent of CPU this job got:        12.00
Major (requiring I/O) page faults:  500168.0
Minor (reclaiming a frame) faults:  38.8



2.4.14-pre3

Same two tests on 2.4.14-pre3 for comparison:

Averages for 10 mtest01 runs
bytes allocated:                    1233859379
User time (seconds):                2.034
System time (seconds):              3.036
Elapsed (wall clock) time:          30.517
Percent of CPU this job got:        16.10
Major (requiring I/O) page faults:  107.0
Minor (reclaiming a frame) faults:  302029.3

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.578
System time (seconds):              17.388
Elapsed (wall clock seconds) time:  171.45
Percent of CPU this job got:        21.20
Major (requiring I/O) page faults:  500158.8
Minor (reclaiming a frame) faults:  41.4

-- 
Randy Hron

