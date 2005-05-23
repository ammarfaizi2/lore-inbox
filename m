Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVEWMPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVEWMPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 08:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVEWMPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 08:15:13 -0400
Received: from femail.waymark.net ([206.176.148.84]:4772 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261249AbVEWMPC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 08:15:02 -0400
Date: 23 May 2005 12:00:44 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: [2.6.12-rc4-mm1|2] [Cyrix MII] C2 au revoir?
To: linux-kernel@vger.kernel.org
Message-ID: <20324c.b73816@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        /proc/acpi/power 2.6.12-rc4

active state:            C2
max_cstate:              C8
bus master activity:     00000000
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[000]
usage[00001360]
   *C2:                  type[C2] promotion[--] demotion[C1] latency[100]
usage[00139993]

..kernels 2.6.12-rc4-mm1|2 miss the C2 entry, and tho experi-
mental ACPI sleep state support puts things to sleep, it won't
wake up now. I haven't checked to see if ACPI resume works yet
with a cs4235 ALSA.

... Chernobyl released more than fifty tons of radioactive material
--- MultiMail/Linux v0.46 [Currently BlueWave packet type]
