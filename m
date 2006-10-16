Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWJPBXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWJPBXg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 21:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWJPBXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 21:23:36 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:36488 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750951AbWJPBXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 21:23:35 -0400
Date: Sun, 15 Oct 2006 21:23:29 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: raw1394 problems galore
To: linux-kernel@vger.kernel.org,
       For users of Fedora Core releases 
	<fedora-list@redhat.com>
Message-id: <4532DF11.9060704@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all;

After about 4 days of snooping around trying to get kino, either 08.xx 
or 0.9.2, to run here, I'm getting noplace at a very high rate of speed.

System is an HP dv5120us lappy, with ddual boot of xp and FC5, with FC5 
about as uptodate as can be managed when the kmod stuff is always 1 or 2 
versions behind the kernel, so I'm still running 2.6.17-1.2174_FC5 for a 
kernel.

Specifically, kino-0.8.0-2.lvn5.i386.rpm can receive and record a/v from 
my camera, a Sony TRV-460, but cannot control it via the av/c controls 
as it cannot 'see' a device to do the controls in the prefs->ieee1394 
screen.

Then kino-0.9.2-1.lvn5.i386.rpm cannot even see the raw1394 interface, 
reporting on its screen that the raw1394 kernel module isn't loaded, or 
that it cannot read/write /dev/raw1394.

The module is loaded when the cable is plugged in, and the 
/etc/security/console.perms.d/50-defaults has been edited so that 
/dev/raw1394 as created by the hotplug event now has these perms:
crw-rw-rw- 1 root root 171, 0 Oct 15 20:20 /dev/raw1394

This has had no effect on the performance of either version of kino.

So when do we actually get a functioning firewire interface, which we 
DID have 18 months ago in FC2, before someone just had to rewrite the 
1394 stuff again?

-- 
Cheers, Gene

