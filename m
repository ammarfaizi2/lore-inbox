Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279887AbRJ3HYm>; Tue, 30 Oct 2001 02:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279888AbRJ3HYW>; Tue, 30 Oct 2001 02:24:22 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:37372 "EHLO
	hawk.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S279887AbRJ3HYN>; Tue, 30 Oct 2001 02:24:13 -0500
Date: Tue, 30 Oct 2001 02:26:40 -0500
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.ent
Cc: torvalds@transmeta.com
Subject: VM test comparison of 2.4.14-pre5, aa1, and 2.4.13-ac5-fs
Message-ID: <20011030022640.A225@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.14-pre5		fastest for mtest01, smoothest sound.
2.4.14pre5aa1
2.4.13-ac5-freeswap	fastest for mmap001

Summary:	

mtest01

2.4.14-pre5 had the lowest wall clock time for mtest01.
2.4.14-pre5 and 2.4.14pre5aa1 played just over 80% of the 
mp3. 2.4.13-ac5-freeswap played 23% of the mp3.

mmap001

2.4.13-ac5-freeswap skipped very little and was about 11%
faster than the pre5 kernels.


2.4.14-pre5
-----------

mtest01

mp3 played 263 seconds of 321 second run.

Averages for 10 mtest01 runs
bytes allocated:                    1241933414
User time (seconds):                2.088
System time (seconds):              3.129
Elapsed (wall clock) time:          32.104
Percent of CPU this job got:        15.70
Major (requiring I/O) page faults:  105.8
Minor (reclaiming a frame) faults:  304000.6

mmap001

No mp3 skips noted.

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.510
System time (seconds):              17.438
Elapsed (wall clock seconds) time:  173.48
Percent of CPU this job got:        20.80
Major (requiring I/O) page faults:  500164.4
Minor (reclaiming a frame) faults:  43.6


2.4.14pre5aa1
-------------

mtest01

mp3 played for 318 seconds of 383 second run.

Averages for 10 mtest01 runs
bytes allocated:                    1250217164
User time (seconds):                2.017
System time (seconds):              2.959
Elapsed (wall clock) time:          38.255
Percent of CPU this job got:        12.60
Major (requiring I/O) page faults:  125.7
Minor (reclaiming a frame) faults:  306016.6


mmap001

mp3 played 823 seconds of 878 second run.

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.496
System time (seconds):              14.450
Elapsed (wall clock seconds) time:  175.54
Percent of CPU this job got:        18.80
Major (requiring I/O) page faults:  500164.4
Minor (reclaiming a frame) faults:  43.8


2.4.13-ac5-freeswap
-------------------

The freeswap patch is from www.surriel.com for 2.4.12-ac3.

mtest01

mp3 played 81 seconds of 352 second run.

Averages for 10 mtest01 runs
bytes allocated:                    1244345139
User time (seconds):                2.104
System time (seconds):              3.815
Elapsed (wall clock) time:          35.153
Percent of CPU this job got:        16.40
Major (requiring I/O) page faults:  113.1
Minor (reclaiming a frame) faults:  304585.4


mmap001

mp3 played 773 seconds of 774 second run

Average for 5 mmap001 runs
bytes allocated:                    2048000000
User time (seconds):                19.160
System time (seconds):              16.748
Elapsed (wall clock seconds) time:  154.70
Percent of CPU this job got:        22.60
Major (requiring I/O) page faults:  500174.8
Minor (reclaiming a frame) faults:  20.0

-- 
Randy Hron

