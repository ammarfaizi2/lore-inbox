Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289319AbSBNBfV>; Wed, 13 Feb 2002 20:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289317AbSBNBfQ>; Wed, 13 Feb 2002 20:35:16 -0500
Received: from pop.sttl.uswest.net ([206.81.192.8]:39953 "HELO
	sttlpop7.sttl.uswest.net") by vger.kernel.org with SMTP
	id <S289319AbSBNBe7>; Wed, 13 Feb 2002 20:34:59 -0500
Date: Wed, 13 Feb 2002 17:34:18 -0800
Message-Id: <E16bAmw-0002W2-00@electron.earth.sickfuck.org>
From: "Ian Eure" <ieure@qwest.net>
To: linux-kernel@vger.kernel.org, linux-laptops@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Reply-To: ieure@qwest.net
Subject: inspiron 8100 freezing
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there. My shiny new Dell Inspiron 8100 arrived in the mail today... Wiped 
Windows XP, installed Debian, and compiled myself a 2.4.17 kernel w/herick's 
IDE patch.

However, the system locks hard when I boot it up. The point where it dies 
varies - it got as far as starting cron one time.

Compiled a vanilla 2.4.17 & got the exact same thing. I'm not doing anything 
exotic.

ACPI is disabled, APM is configured thusly:

CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

The 2.2.20 kernel that Debian installed seems to work ok.

Anyone else seeing anything like this?

P.S. Please CC me on replies, I'm not subscribed. Thanks.
