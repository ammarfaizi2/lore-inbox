Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130656AbRCIUmX>; Fri, 9 Mar 2001 15:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbRCIUmN>; Fri, 9 Mar 2001 15:42:13 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:34247 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S130656AbRCIUl7>; Fri, 9 Mar 2001 15:41:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dennis Noordsij <dennis.noordsij@wiral.com>
To: linux-kernel@vger.kernel.org
Subject: APM battery status reporting
Date: Fri, 9 Mar 2001 22:41:03 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01030922410300.00458@dennis>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Dell Inspiron 5000e laptop which works beautifully with 2.4.2, 
including suspends, DRM, etc etc.

One thing that has never worked though is battery status reporting 
(/proc/apm). However people who sell this exact same laptop with Linux 
preinstalled (mostly redhat though with their patched kernel, I use Debian 
with stock kernel) tell me their battery status reporting does indeed work. 
Via google.com/linux I have found several older posts in this list (Q4 2000) 
mentioning this exact laptop and patches that do enable this feature being 
tested in previous kernels. Then again my dmesg says the BIOS is probably 
buggy (same BIOS though as mentioned in those posts). Apmd does notice the 
change from mains to battery and vice versa (I have disabled Speedstep so now 
everything actually survives this transition :-).

So to end all the confusion, is there a patch out there that enables battery 
status reporting for me (and other Dell owners :-) ?

Thanks in advance for any pointers,
Kind regards,
Dennis Noordsij

dmesg:

BIOS strings suggest APM bugs, disabling power status reporting.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)


kernel configuration:

CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y

# CONFIG_ACPI is not set


/proc/apm:

1.14 1.2 0x03 0xff 0xff 0xff -1% -1 ?

