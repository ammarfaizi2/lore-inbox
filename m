Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313807AbSDIAwA>; Mon, 8 Apr 2002 20:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313808AbSDIAv7>; Mon, 8 Apr 2002 20:51:59 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:46855 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313807AbSDIAv5>;
	Mon, 8 Apr 2002 20:51:57 -0400
Date: Mon, 8 Apr 2002 20:51:52 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: New (Final?) Watchdog Updates
Message-ID: <Pine.LNX.4.33.0204082047060.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, thanks to all those who have commented on or pointed out my
idiocy in this patch.  I've put up a new version of the watchdog updates
at http://osinvestor.com/bigwatchdog-7.diff against 2.4.19-pre5-ac3.
Diff is 101k, 3800 lines with context, diffstat:

 Documentation/pcwd-watchdog.txt       |  132 -----------
 Documentation/watchdog-api.txt        |  390 ----------------------------------
 Documentation/watchdog.txt            |  113 ---------
 Documentation/watchdog/api.txt        |  139 ++++++++++++
 Documentation/watchdog/howtowrite.txt |   62 +++++
 Documentation/watchdog/status.txt     |  137 +++++++++++
 drivers/char/acquirewdt.c             |  100 +++++---
 drivers/char/advantechwdt.c           |   88 ++++---
 drivers/char/alim7101_wdt.c           |   85 ++++---
 drivers/char/eurotechwdt.c            |   65 +++--
 drivers/char/i810-tco.c               |   68 +++--
 drivers/char/ib700wdt.c               |   87 ++++---
 drivers/char/machzwd.c                |   96 ++++----
 drivers/char/mixcomwd.c               |   24 --
 drivers/char/pcwd.c                   |   26 +-
 drivers/char/sbc60xxwdt.c             |   77 ++++--
 drivers/char/sc1200wdt.c              |   68 +++--
 drivers/char/sc520_wdt.c              |   81 ++++---
 drivers/char/shwdt.c                  |   86 ++++---
 drivers/char/softdog.c                |   30 +-
 drivers/char/w83877f_wdt.c            |   73 ++++--
 drivers/char/wafer5823wdt.c           |   65 ++++-
 drivers/char/wdt.c                    |   33 ++
 drivers/char/wdt285.c                 |   26 --
 drivers/char/wdt977.c                 |  137 ++++++++---
 drivers/char/wdt_pci.c                |   23 --
 drivers/sbus/char/riowatchdog.c       |    6
 27 files changed, 1188 insertions(+), 1129 deletions(-)

Again, I'd love some comments on the documentation changes.

Regards,
Rob Radez


