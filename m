Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280462AbRKJFEh>; Sat, 10 Nov 2001 00:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280460AbRKJFE1>; Sat, 10 Nov 2001 00:04:27 -0500
Received: from ohiper1-207.apex.net ([209.250.47.222]:10506 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S280462AbRKJFEQ>; Sat, 10 Nov 2001 00:04:16 -0500
Date: Fri, 9 Nov 2001 23:04:39 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: andrea@e-mind.com
Subject: Insanely high "Cached" value
Message-ID: <20011109230439.A13013@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org, andrea@e-mind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 11:01pm  up 12 days,  5:38,  0 users,  load average: 1.30, 1.68, 1.52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system has been running a little over twelve days now, and I just
noticed that the "Cached" value in both 'free' and /proc/meminfo is
insanely high.  This wasn't the case the last time I checked, which was
probably a day ago.

Just before checking it this time, I ran a "du -s *" in /usr, which
generated a lot of I/O, as it to be expected.  Perhaps the large amount
of I/O has uncovered a bug of some sort?

This is kernel 2.4.13 (hopefully it's not something that's already been
reported and fixed; I haven't seen it if is has) patched with ext3, kdb,
lm_sensors, and the pre-empt patch.  Seems likely to be only a simple VM
problem, however, and an asthetic one at that.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
Freedom is slavery. Ignorance is strength. War is peace.
			-- George Orwell
Those that would give up a necessary freedom for temporary safety
deserver neither freedom nor safety.
			-- Ben Franklin
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
