Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280681AbRKBNKv>; Fri, 2 Nov 2001 08:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280682AbRKBNKl>; Fri, 2 Nov 2001 08:10:41 -0500
Received: from fw-akustik.rz.RWTH-Aachen.DE ([137.226.38.42]:55984 "EHLO
	verdi.akustik.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S280681AbRKBNK0>; Fri, 2 Nov 2001 08:10:26 -0500
Message-ID: <3BE29B41.65889D33@akustik.rwth-aachen.de>
Date: Fri, 02 Nov 2001 14:10:25 +0100
From: Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>
Reply-To: Andreas.Franck@akustik.rwth-aachen.de
Organization: Institut =?iso-8859-1?Q?f=FCr?= Technische Akustik
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Weird /proc/meminfo output on 2.4.13-ac5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

since about two days I'm running a machine here with 2.4.13-ac5,
and am quite satisfied with the performance. But now, I noticed
some strange output in /proc/meminfo:

$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  789250048 781295616  7954432   659456 402890752
18446744073478758400
Swap: 6744576000   282624 6744293376
MemTotal:       770752 kB
MemFree:          7768 kB
MemShared:         644 kB
Buffers:        393448 kB
Cached:       4294741680 kB     <------ This is impossible, i think? :-)
SwapCached:        232 kB
Active:         254160 kB
Inact_dirty:    307272 kB
Inact_clean:        80 kB
Inact_target:   157284 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       770752 kB
LowFree:          7768 kB
SwapTotal:     6586500 kB
SwapFree:      6586224 kB

The machine is an AMD Athlon 1200, with 768 MB RAM and about 6G swap.
Is there anything more you need to investigate this problem? Then please
don't hesitate to ask.

Greetings,
Andreas
