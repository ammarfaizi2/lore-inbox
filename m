Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270715AbRHKEcq>; Sat, 11 Aug 2001 00:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270717AbRHKEcg>; Sat, 11 Aug 2001 00:32:36 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:37640 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S270715AbRHKEcS>;
	Sat, 11 Aug 2001 00:32:18 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Walter Hofmann <walterh@gmx.de>
cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac11 
In-Reply-To: Your message of "Fri, 10 Aug 2001 22:05:02 +0200."
             <20010810220502.A32055@frodo.uni-erlangen.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 Aug 2001 14:32:23 +1000
Message-ID: <30061.997504343@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001 22:05:02 +0200, 
Walter Hofmann <walterh@gmx.de> wrote:
>I'm getting this compile error with 2.4.7ac11. Last version I tried was
>2.4.6ac1, which worked fine.
>
>make[4]: Entering directory
>`/usr/src/linux-2.4.7-ac11-int2.4.3.1-path/drivers/scsi/aic7xxx/aicasm'
>gcc -I/usr/include -I. -ldb aicasm_gram.c aicasm_scan.c aicasm.c
>aicasm_symbol.c -o aicasm /usr/i486-linux/bin/ld: cannot open -ldb: No
>such file or directory collect2: ld returned 1 exit status make[4]: ***

Turn off CONFIG_AIC7XXX_BUILD_FIRMWARE.

I have said it before and I will keep saying it until somebody takes
notice.  The aic7xxx Makefiles are *BROKEN*.

I have a standing offer to rewrite the aic7xxx kernel build for 2.4 so
it is done correctly and removes these persistent problems.  All it
needs is for the aic7xxx maintainer to agree that the 2.4 makefiles are
wrong and to let me correct them.

Keith Owens, kernel build maintainer.

