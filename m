Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291370AbSBSMgx>; Tue, 19 Feb 2002 07:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291372AbSBSMgm>; Tue, 19 Feb 2002 07:36:42 -0500
Received: from [212.48.154.34] ([212.48.154.34]:55716 "EHLO gate.stelt.ru")
	by vger.kernel.org with ESMTP id <S291370AbSBSMgb>;
	Tue, 19 Feb 2002 07:36:31 -0500
Date: Tue, 19 Feb 2002 15:40:04 +0300
From: Advisories <advisories@stelt.ru>
X-Mailer: The Bat! (v1.53d)
Organization: STELT Telecom
X-Priority: 3 (Normal)
Message-ID: <73925952749.20020219154004@stelt.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-rc1 freezing while switching to console
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All!

Tested system:
CPU:   AMD Duron 700
MB:    GA-7ZM
RAM:   256Mb
VIDEO: nVidia TNT AGP

kernel 2.4.16 work fine!

kernel 2.4.18-rc1 with same configuration

system started, X login message diplayed
when pressed Ctrl+Alt+F1 system freeze with blank screen :(
only _reset_ can help

unfortunaly, while rebooting system X Window also tried switch console
mode... ugh %(

other kernel versions not tested.

kernel configuration highlights:
CONFIG_M586=y
CONFIG_SMP=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_8139TOO=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y

Software configuration based on RedHat-7.1
highlights:
gcc-2.96-99
glibc-2.2.2-10
XFree86-4.0.3-5
binutils-2.11.92.0.12-9
kde-2.2.2


Vlad

---------------------------------------------------
Advisories               mailto:advisories@stelt.ru

