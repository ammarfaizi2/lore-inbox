Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTI3UC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 16:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTI3UC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 16:02:26 -0400
Received: from pop.gmx.net ([213.165.64.20]:33229 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261699AbTI3UCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 16:02:22 -0400
X-Authenticated: #18658533
Date: Tue, 30 Sep 2003 22:00:10 +0200
From: Knezevic Nikola <nikkne@gmx.ch>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Nikola Knezevic <nikkne@gmx.ch>
Organization: necto
X-Priority: 3 (Normal)
Message-ID: <1199103055.20030930220010@gmx.ch>
To: Nikola Knezevic <nikkne@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: <oops when unplugging USB Flash disk, somewhere in SCSI subsystem>
In-Reply-To: <1073768233.20030926151646@gmx.ch>
References: <1073768233.20030926151646@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Congrats, the problem isn't there anymore:))

Now (with -test6), when I plug in my USB flash disk, SCSI subsystem
isn't up (there are no sd_mod and/or sg loaded).
When I manualy load sd_mod and sg, plug in USB disk, everything goes ok,
but the horor-scene arises when unplugging. one oops pops up, and after
couple of moments another one, which blocks the system. I can send
oops-report, if anyone asks.

NK> [1.] One line summary of the problem:
NK> oops when unplugging USB Flash disk, somewhere in SCSI subsystem

NK> [2.] Full description of the problem/report:
NK> I'm using hotplug to mount my USB Flash disk as soon it is plugged in.
NK> It works fine, until I unplug it, which prodeuces oops. After plugging
NK> it again, it can't be mounted.

NK> [3.] Keywords (i.e., modules, networking, kernel):
NK> modules, hotplugging, USB, SCSI, sd_mod, usb-storage, kernel

NK> [4.] Kernel version (from /proc/version):
NK> Linux version 2.6.0-test5 (root@hunin) (gcc version 3.2.2) #6 Thu Sep 25 23:02:57 CEST 2003

