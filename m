Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUGSWYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUGSWYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 18:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUGSWYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 18:24:53 -0400
Received: from avarice.ph.ed.ac.uk ([129.215.73.46]:49352 "EHLO
	avarice.ph.ed.ac.uk") by vger.kernel.org with ESMTP id S264266AbUGSWYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 18:24:42 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 kernel
From: Philip Clark <P.J.Clark@ed.ac.uk>
Date: Mon, 19 Jul 2004 23:24:40 +0100
Message-ID: <x02macxvskif.fsf@maverick.ph.ed.ac.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have been using the 2.6 kernel with my DELL latitude CPiA 366XT now
for sometime and it works great, but there are some quirks which would
be worth trying to get fixed, most are related to apm.

It used to be that when the battery power became low the machine would
automatically suspend to disk. This seems to be disable now and the
machine just crashes. 

fn + D used to blank the screen in 2.4 and in 2.6 it only blanks it
momentarily. 

If I suspend with my pcmcia wireless card in place and disconnect the ac
cord when suspended then it always crashes. 

There are quite a few things like this I would help to try to debug. 

Here are my config settings, I've tried the "display blank" to no
avail. 

Anyone have any ideas?

Thanks for any help

-Phil

CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BOOT=y

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
