Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292900AbSCIT5y>; Sat, 9 Mar 2002 14:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292904AbSCIT5p>; Sat, 9 Mar 2002 14:57:45 -0500
Received: from prahaa-4-18.dialup.vol.cz ([195.122.214.89]:38529 "EHLO
	pida.in.idoox.com") by vger.kernel.org with ESMTP
	id <S292901AbSCIT5g>; Sat, 9 Mar 2002 14:57:36 -0500
Date: Sat, 9 Mar 2002 20:49:16 +0100
From: David Hajek <david@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: apm problems on thinkpad
Message-ID: <20020309204916.A5134@pida.in.idoox.com>
Reply-To: david@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.18
Organization: Systinet, Inc. [formerly Idoox]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

 I have several problems with APM on my IBM Thinkpad R30
laptop. Standby mode (apm -s) does not work properly,
because all fans are running. Laptop survives no more
than hour when in standby mode, because all battery
power is eatten. Is it possible to stop them? ;-) I try
the same with win2k and it works fine. 

Its interesting that resume works fine - no locks or
some other problems with it.

I am running 2.4.18 with ide.2.4.18rc1.

Other configs:

CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y

# cat /proc/apm
1.16 1.2 0x07 0x01 0x00 0x01 100% -1 ?

# cat /etc/redhat-release 
Red Hat Linux release 7.2 (Enigma)

Thanks.

-David
