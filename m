Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSEEMJF>; Sun, 5 May 2002 08:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311180AbSEEMJE>; Sun, 5 May 2002 08:09:04 -0400
Received: from vivi.uptime.at ([62.116.87.11]:65487 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S311121AbSEEMJD>;
	Sun, 5 May 2002 08:09:03 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: <thunder7@xs4all.nl>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.13 on alpha - undefined symbol local_irq_save in snd-seq-midi-event.o
Date: Sun, 5 May 2002 14:06:23 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000001c1f42d$49e73780$1201a8c0@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020504183127.GA8700@alpha.of.nowhere>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan wrote:
> cd /lib/modules/2.5.13; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln 
> -sf ../{} pcmcia if [ -r System.map ]; then /sbin/depmod -ae 
> -F System.map  2.5.13; fi
> depmod: *** Unresolved symbols in 
> /lib/modules/2.5.13/kernel/sound/core/seq/snd-seq-midi-event.o
> depmod:         local_irq_save
> depmod:         local_irq_restore
> make: *** [_modinst_post] Error 1
> 
> alpha:/usr/src/linux-2.5.13-jwk#

I guess sound is not jet implemented in 2.5!?

But do you really need 2.5? Is it not enough to you to use
2.4? 2.4.18 works great on my system!

-Oliver


