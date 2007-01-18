Return-Path: <linux-kernel-owner+w=401wt.eu-S1751400AbXARVU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXARVU2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXARVU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:20:27 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:2084 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751400AbXARVU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:20:27 -0500
Date: Thu, 18 Jan 2007 22:20:42 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] More hwmon updates for 2.6.20
Message-Id: <20070118222042.89c71dba.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the late hwmon subsystem updates for Linux 2.6.20 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

They fix several problems that were found in the new w83793 hardware
monitoring driver.

 Documentation/hwmon/w83793 |    8 +--
 drivers/hwmon/hwmon-vid.c  |    2 -
 drivers/hwmon/w83793.c     |  127 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 113 insertions(+), 24 deletions(-)

---------------

Gong Jun:
      hwmon/w83793: Remove the description of AMDSI and update the voltage formula
      hwmon/w83793: Ignore disabled temperature channels
      hwmon/w83793: Hide invalid VID readings

Jean Delvare:
      hwmon: Fix the VRD 11 decoding

Rudolf Marek:
      hwmon/w83793: Fix the fan input detection

Thanks,
-- 
Jean Delvare
