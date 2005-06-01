Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVFAGOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVFAGOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 02:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVFAGOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 02:14:52 -0400
Received: from femail.waymark.net ([206.176.148.84]:53200 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261286AbVFAGOr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 02:14:47 -0400
Date: 1 Jun 2005 06:08:30 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: Re: [ACPI] 2.6.12-rc5
To: linux-kernel@vger.kernel.org
Message-ID: <7032c6.c1090f@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> Pavel Machek wrote to Kenneth Parrish <=-

Re: ACPI sleep states and 2.6.12-rc5, VIA VP3, Cyrix MII:
    not wakeable after delay

 PM> Did it work properly in any previous kernel?
The testing sleep periods were mostly short, but, a couple of
times it wouldn't wake - i think only after longer stand-bys. i don't
recall the kernel versions. 2.6.12-rc4-mm1 and -mm2 don't wake at all.
and there's the C1 state at /proc/acpi/processor/CPU0/power but no C2 .

14!cat /proc/acpi/processor/CPU0/power  # 2.6.12-rc5

active state:            C2
max_cstate:              C8
bus master activity:     00000000
states:
    C1:                  type[C1] promotion[C2] demotion[--] latency[000]
usage[00021770]
   *C2:                  type[C2] promotion[--] demotion[C1] latency[100]
usage[01209363]

--- MultiMail/Linux v0.46
