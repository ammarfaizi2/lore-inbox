Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSFBC2k>; Sat, 1 Jun 2002 22:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317116AbSFBC2j>; Sat, 1 Jun 2002 22:28:39 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:6156 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S317115AbSFBC2j>;
	Sat, 1 Jun 2002 22:28:39 -0400
Date: Sat, 1 Jun 2002 22:28:37 -0400
From: Rob Radez <rob@osinvestor.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org, Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH] Watchdog Stuff (1/4)
Message-ID: <20020601222837.A30977@osinvestor.com>
In-Reply-To: <20020601064309.GA10222@insight.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just put up a copy of my tree with Joel's stuff merged in at
http://junker.org/~rradez/wd/

 Documentation/pcwd-watchdog.txt       |  132 ---
 Documentation/watchdog-api.txt        |  390 -----------
 Documentation/watchdog.txt            |  113 ---
 Documentation/watchdog/api.txt        |  148 ++++
 Documentation/watchdog/howtowrite.txt |   78 ++
 Documentation/watchdog/status.txt     |  151 ++++
 drivers/char/acquirewdt.c             |  209 +++---
 drivers/char/advantechwdt.c           |   40 -
 drivers/char/alim7101_wdt.c           |  161 ++--
 drivers/char/eurotechwdt.c            |  118 +--
 drivers/char/i810-tco.c               |  119 ++-
 drivers/char/i810-tco.h               |   10 
 drivers/char/ib700wdt.c               |  173 +++--
 drivers/char/indydog.c                |   71 +-
 drivers/char/machzwd.c                |  243 +++----
 drivers/char/mixcomwd.c               |  176 ++---
 drivers/char/pcwd.c                   | 1164 +++++++++++++++++++++-------------
 drivers/char/sbc60xxwdt.c             |  254 ++++---
 drivers/char/sc1200wdt.c              |   31 
 drivers/char/sc520_wdt.c              |  191 +++--
 drivers/char/shwdt.c                  |   17 
 drivers/char/softdog.c                |  111 ++-
 drivers/char/w83877f_wdt.c            |  186 ++---
 drivers/char/wafer5823wdt.c           |  151 +++-
 drivers/char/wd501p.h                 |    4 
 drivers/char/wdt.c                    |  165 ++--
 drivers/char/wdt285.c                 |   85 +-
 drivers/char/wdt977.c                 |  203 +++--
 drivers/char/wdt_pci.c                |  165 ++--
 drivers/sbus/char/cpwatchdog.c        |  132 +--
 drivers/sbus/char/riowatchdog.c       |    6 
 include/linux/watchdog.h              |    3 
 32 files changed, 2868 insertions(+), 2332 deletions(-)

Changes since last time include changing some contact information, killing
all trailing white space (which is what inflated the patch size), and
integrating Joel's changes in.

Regards,
Rob Radez
