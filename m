Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSHJIhN>; Sat, 10 Aug 2002 04:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSHJIhN>; Sat, 10 Aug 2002 04:37:13 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:12416 "EHLO stargate")
	by vger.kernel.org with ESMTP id <S316673AbSHJIhM>;
	Sat, 10 Aug 2002 04:37:12 -0400
Date: Sat, 10 Aug 2002 10:41:02 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre1-ac1 does not compile
Message-ID: <20020810084102.GC4636@stargate.lan>
References: <3D54CC7F.3C758EDB@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D54CC7F.3C758EDB@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there is a patch for this problem.

you can take this patch with a nntp client : the newsgroup is :
linux.kernel

stephane wirtel

On sam, 10 aoû 2002, Jean-Luc Coulon wrote:
> And here are the messages :
> gcc -D__KERNEL__ -I/usr/src/kernel-source-2.4.20-pre1-ac1/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6  
> -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
> -DKBUILD_BASENAME=apm  -c -o apm.o apm.c
> apm.c: In function `apm_bios_call':
> apm.c:605: called object is not a function
> apm.c:605: warning: unused variable `cpus'
> apm.c: In function `apm_bios_call_simple':
> apm.c:654: called object is not a function
> apm.c:654: warning: unused variable `cpus'
> apm.c: In function `apm_power_off':
> apm.c:938: called object is not a function
> {entrée standard}: Messages de l'assembleur:
> {entrée standard}:239: AVERTISSEMENT:indirect lcall sans « * »
> {entrée standard}:333: AVERTISSEMENT:indirect lcall sans « * »
> make[2]: *** [apm.o] Erreur 1
> make[2]: Leaving directory
> `/usr/src/kernel-source-2.4.20-pre1-ac1/arch/i386/kernel'
> make[1]: *** [_dir_arch/i386/kernel] Erreur 2
> 
> 2.4.20-pre1 compiles fine
> 
> And here my apm related config :
> CONFIG_APM=y
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> CONFIG_APM_CPU_IDLE=y
> CONFIG_APM_DISPLAY_BLANK=y
> CONFIG_APM_RTC_IS_GMT=y
> # CONFIG_APM_ALLOW_INTS is not set
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> 
> ----
> regards
>         Jean-Luc
> 
> (I'm not on the list)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
Address :
    Rue de cartier, 53
    6030 Marchienne-au-Pont
    Belgium
Phone :	+32 474 768 072
