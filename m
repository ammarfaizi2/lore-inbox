Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262379AbSJKJpc>; Fri, 11 Oct 2002 05:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSJKJpc>; Fri, 11 Oct 2002 05:45:32 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:3551 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S262379AbSJKJpa>; Fri, 11 Oct 2002 05:45:30 -0400
Date: Fri, 11 Oct 2002 10:46:55 +0100
From: Stig Brautaset <stig@brautaset.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.41: apm hangs instead of suspending
Message-ID: <20021011094655.GA23907@arwen.brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Location: London, UK
X-URL: http://brautaset.org
X-KeyServer: wwwkeys.nl.pgp.net
X-PGP/GnuPG-Key: 9336ADC1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a Latitude CPx H500GT, and I use these settings for apm in 2.5.41:

ONFIG_ACPI is not set
CONFIG_PM=y
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

This is the same settings that works just fine under 2.4.19. I've tried turning
on the "don't crash when suspending" knob, but to no avail.

Stig
-- 
brautaset.org
