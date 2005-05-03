Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVECPQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVECPQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVECPQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:16:22 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:26827 "EHLO
	thumper2.allantgroup.com") by vger.kernel.org with ESMTP
	id S261729AbVECPPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:15:53 -0400
Date: Tue, 3 May 2005 10:15:32 -0500
From: Andy <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: WARNING : kernel 2.6.11.7 (others) kills megaraid 4e/Si dead
Message-ID: <20050503151532.GA1316@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cross posted due to the severity of this issue.

I have killed two Dell 1850 (x86_64) with megaraid 4e/SI servers using
kernel 2.6.11.7.  When the system boots, it looks like it does not see the
megaraid controller (because it never prints anything about it) and hangs
when it tries to mount root.  When rebooted, the system says no firmware
present for embedded raid controller.  I then try to flash it, the flash
program says the firmware is corrupt and flashes the controller.  However,
upon reboot I still get the no firmware present, thus the machine can no
longer boot off the raid.

Andy
