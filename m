Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265371AbUFRQre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbUFRQre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266213AbUFRQre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:47:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55823 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265371AbUFRQnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:43:08 -0400
Date: Fri, 18 Jun 2004 09:23:13 -0700
Message-Id: <200406181623.i5IGND6j027432@fire-2.osdl.org>
From: bugme-daemon@osdl.org
To: rmk@arm.linux.org.uk
Subject: [Bug 2905] Aironet 340 PCMCIA card not working since 2.6.7
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Category: Drivers
X-Bugzilla-Component: PCMCIA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2905





------- Additional Comments From hadmut@danisch.de  2004-06-18 09:23 -------
I was doing some more tests and found the problem:

I have a script doing the configuration of the aironet card
through the /proc/driver/aironet/eth0 interface. This does not 
work anymore, I can't even change the SSID, which worked with
2.6.6. However, using iwconfig works.

Is the procfs support going to be abandoned?

regards
Hadmut


------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
