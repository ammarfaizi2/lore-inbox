Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313547AbSDHDpu>; Sun, 7 Apr 2002 23:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313548AbSDHDpt>; Sun, 7 Apr 2002 23:45:49 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:41991 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313547AbSDHDpt>;
	Sun, 7 Apr 2002 23:45:49 -0400
Date: Sun, 7 Apr 2002 23:45:45 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: Further WatchDog Updates
Message-ID: <Pine.LNX.4.33.0204072342550.17511-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, new version of watchdog updates is up at
http://osinvestor.com/bigwatchdog-4.diff

This also includes replacing the three watchdog docs in Documentation/
and slight modification of the watchdog API after discussion with Alan Cox.

Diffstat:
 Documentation/pcwd-watchdog.txt       |  132 -----------
 Documentation/watchdog-api.txt        |  390 ----------------------------------
 Documentation/watchdog.txt            |  113 ---------
 Documentation/watchdog/api.txt        |  139 ++++++++++++
 Documentation/watchdog/howtowrite.txt |   55 ++++
 Documentation/watchdog/status.txt     |  137 +++++++++++
 drivers/char/acquirewdt.c             |  100 +++++---
 drivers/char/advantechwdt.c           |   88 ++++---
 drivers/char/alim7101_wdt.c           |   83 ++++---
 drivers/char/eurotechwdt.c            |   65 +++--
 drivers/char/i810-tco.c               |   68 +++--
 drivers/char/ib700wdt.c               |   87 ++++---
 drivers/char/machzwd.c                |   96 ++++----
 drivers/char/mixcomwd.c               |   24 --
 drivers/char/pcwd.c                   |   26 +-
 drivers/char/sbc60xxwdt.c             |   75 ++++--
 drivers/char/sc1200wdt.c              |   30 --
 drivers/char/sc520_wdt.c              |   55 ++--
 drivers/char/shwdt.c                  |   67 ++---
 drivers/char/softdog.c                |   30 +-
 drivers/char/w83877f_wdt.c            |   52 ++--
 drivers/char/wafer5823wdt.c           |   45 +++
 drivers/char/wdt.c                    |   33 ++
 drivers/char/wdt285.c                 |   26 --
 drivers/char/wdt977.c                 |  137 ++++++++---
 drivers/char/wdt_pci.c                |   23 --
 26 files changed, 1063 insertions(+), 1113 deletions(-)

Please take a look at it, especially the documentation.

Regards,
Rob Radez

