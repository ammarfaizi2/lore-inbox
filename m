Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288372AbSACXFx>; Thu, 3 Jan 2002 18:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288376AbSACXFn>; Thu, 3 Jan 2002 18:05:43 -0500
Received: from ausxc07.us.dell.com ([143.166.227.166]:334 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S288372AbSACXFa>; Thu, 3 Jan 2002 18:05:30 -0500
Message-ID: <71714C04806CD5119352009027289217022C417D@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
Cc: nils@kernelconcepts.de, giometti@ascensit.com, pb@nexus.co.uk,
        chowes@vsol.net, gorgo@itc.hu, info@itc.hu, lethal@chaoticdreams.org,
        woody@netwinder.org
Subject: RE: [CFT][PATCH] watchdog nowayout and timeout module parameters
Date: Thu, 3 Jan 2002 17:05:19 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No changes, just forward-ported the patches.  
14 drivers modified, 5 drivers approved, one (wdt977) being handled by its
maintainer, two email addresses 
invalid, leaving 6 to hear from.

Patch against 2.4.18-pre1 at
http://domsch.com/linux/patches/linux-2.4.18-pre1-nowayout-20020103.patch
 acquirewdt.c   |   21 ++++++++++++---
 advantechwdt.c |   42 ++++++++++++++++++++++++++-----
 eurotechwdt.c  |   49 ++++++++++++++++++++++++++++---------
 i810-tco.c     |   32 +++++++++++++++++++-----
 ib700wdt.c     |   39 +++++++++++++++++++++++++----
 machzwd.c      |   48 ++++++++++++++++++++++--------------
 mixcomwd.c     |   75
+++++++++++++++++++++++++++++++--------------------------
 pcwd.c         |   45 +++++++++++++++++++++++++---------
 sbc60xxwdt.c   |   14 +++++++++-
 shwdt.c        |   21 +++++++++++++--
 softdog.c      |   33 +++++++++++++++++--------
 wdt.c          |   41 +++++++++++++++++++++++++------
 wdt_pci.c      |   43 +++++++++++++++++++++++++-------
 13 files changed, 374 insertions(+), 129 deletions(-)

Patch against 2.5.2-pre6 at
http://domsch.com/linux/patches/linux-2.5.2-pre6-nowayout-20020103.patch
 acquirewdt.c   |   21 ++++++++++++----
 advantechwdt.c |   42 ++++++++++++++++++++++++++------
 eurotechwdt.c  |   49 +++++++++++++++++++++++++++++--------
 i810-tco.c     |   32 +++++++++++++++++++-----
 ib700wdt.c     |   39 ++++++++++++++++++++++++++----
 machzwd.c      |   48 +++++++++++++++++++++++-------------
 mixcomwd.c     |   74
+++++++++++++++++++++++++++++++--------------------------
 pcwd.c         |   47 ++++++++++++++++++++++++++----------
 sbc60xxwdt.c   |   14 ++++++++++
 shwdt.c        |   21 +++++++++++++---
 softdog.c      |   33 +++++++++++++++++--------
 wdt.c          |   41 +++++++++++++++++++++++++------
 wdt_pci.c      |   43 +++++++++++++++++++++++++--------
 13 files changed, 374 insertions(+), 130 deletions(-)


Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
#1 US Linux Server provider with 24.5% (IDC Dec 2001)
#2 Worldwide Linux Server provider with 18.2% (IDC Dec 2001)
