Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSHGBJf>; Tue, 6 Aug 2002 21:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSHGBJf>; Tue, 6 Aug 2002 21:09:35 -0400
Received: from sc-grnvl-66-169-0-54.chartersc.net ([66.169.0.54]:39047 "EHLO
	rhino") by vger.kernel.org with ESMTP id <S316610AbSHGBIv>;
	Tue, 6 Aug 2002 21:08:51 -0400
Subject: Re: Linux 2.4.20-pre1 - compile errors
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: alan@redhat.com
In-Reply-To: <200208062329.g76NTqP30962@devserv.devel.redhat.com>
References: <200208062329.g76NTqP30962@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 06 Aug 2002 21:12:29 -0400
Message-Id: <1028682750.5057.4.camel@rhino>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o       Export the new pci_enable function to modules   (Tomas Szepe)
> o       Handle APM on armada laptops                    (Samuel Thibault)
> o       Fix further errors in depca?
> o       Fix a harmless physical/logical cpu confusion   (me)
>         in the APM code
> -       Fix migration to CPU 0 before poweroff          (me)
> o       Make the APM on CPU 0 locking cover all of APM  (me)
>         | idle on SMP needs work, but this seems to work for the rest
>         | with my SMP boxes

apm.c: In function `apm_bios_call':
apm.c:605: called object is not a function
apm.c:605: warning: unused variable `cpus'
apm.c: In function `apm_bios_call_simple':
apm.c:654: called object is not a function
apm.c:654: warning: unused variable `cpus'
apm.c: In function `apm_power_off':
apm.c:938: called object is not a function

make[1]: *** [apm.o] Error 1

This is on a non-SMP system.

Billy

