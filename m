Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSHJIQP>; Sat, 10 Aug 2002 04:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSHJIQP>; Sat, 10 Aug 2002 04:16:15 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:10698 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316672AbSHJIQO>; Sat, 10 Aug 2002 04:16:14 -0400
Message-ID: <3D54CC7F.3C758EDB@wanadoo.fr>
Date: Sat, 10 Aug 2002 10:19:11 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre1-ac1 does not compile
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here are the messages :
gcc -D__KERNEL__ -I/usr/src/kernel-source-2.4.20-pre1-ac1/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6  
-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=apm  -c -o apm.o apm.c
apm.c: In function `apm_bios_call':
apm.c:605: called object is not a function
apm.c:605: warning: unused variable `cpus'
apm.c: In function `apm_bios_call_simple':
apm.c:654: called object is not a function
apm.c:654: warning: unused variable `cpus'
apm.c: In function `apm_power_off':
apm.c:938: called object is not a function
{entrée standard}: Messages de l'assembleur:
{entrée standard}:239: AVERTISSEMENT:indirect lcall sans « * »
{entrée standard}:333: AVERTISSEMENT:indirect lcall sans « * »
make[2]: *** [apm.o] Erreur 1
make[2]: Leaving directory
`/usr/src/kernel-source-2.4.20-pre1-ac1/arch/i386/kernel'
make[1]: *** [_dir_arch/i386/kernel] Erreur 2

2.4.20-pre1 compiles fine

And here my apm related config :
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

----
regards
        Jean-Luc

(I'm not on the list)
