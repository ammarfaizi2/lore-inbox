Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312928AbSDGCuE>; Sat, 6 Apr 2002 21:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312930AbSDGCuD>; Sat, 6 Apr 2002 21:50:03 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:33031 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S312928AbSDGCuD>;
	Sat, 6 Apr 2002 21:50:03 -0500
Date: Sat, 6 Apr 2002 21:49:57 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: WatchDog Driver Updates
Message-ID: <Pine.LNX.4.33.0204062139010.3791-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've put up a patch on http://osinvestor.com/bigwatchdog.diff against
2.4.19-pre5-ac3.  The diff is 33k, and it affects 19 files in drivers/char/,
here's a diffstat of it:
 acquirewdt.c   |   25 ++++-----------------
 advantechwdt.c |   21 ++++--------------
 alim7101_wdt.c |   27 +++++++++++------------
 eurotechwdt.c  |   23 ++++++--------------
 i810-tco.c     |    7 ++----
 ib700wdt.c     |   21 ++++--------------
 machzwd.c      |   31 +++++++--------------------
 mixcomwd.c     |   11 +++------
 sbc60xxwdt.c   |   23 ++++++++++----------
 sc1200wdt.c    |    8 -------
 sc520_wdt.c    |   28 +++++++++---------------
 shwdt.c        |   16 ++++----------
 softdog.c      |    5 +++-
 w83877f_wdt.c  |   19 ++++++++--------
 wafer5823wdt.c |    3 --
 wdt.c          |    1
 wdt285.c       |   23 +++++++++-----------
 wdt977.c       |   65 +++++++++++++++++++++++++++++++++++++++++++++++---------- wdt_pci.c      |    9 +------
 19 files changed, 162 insertions(+), 204 deletions(-)

It's all fairly minor changes, I think, but I would appreciate any comments
on it.

Regards,
Rob Radez

