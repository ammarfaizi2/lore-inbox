Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbREAAhz>; Mon, 30 Apr 2001 20:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133053AbREAAhp>; Mon, 30 Apr 2001 20:37:45 -0400
Received: from tunnel-44-207.vpn.uib.no ([129.177.44.207]:19716 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130900AbREAAha>; Mon, 30 Apr 2001 20:37:30 -0400
Message-ID: <3AEE05AE.1090101@fi.uib.no>
Date: Tue, 01 May 2001 02:39:10 +0200
From: Igor Bukanov <boukanov@fi.uib.no>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can eject mounted zip disk after suspend/resume (2.4.4)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I hit an eject button on internal IDE IOMEGA zip drive after 
resume/suspend to memory on my Dell Inspiron 7500 notebook, then the 
disk will be ejected even if it is mounted. This behavior happens ONLY 
if I suspend my system with the mounted zip. Could I fix this somehow?

I tried to use both ide-floppy and ide-scsi drivers to access the disk 
with no difference.

My settings for 2.4.4 kernel APM options are
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

Regards, Igor

