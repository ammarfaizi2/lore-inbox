Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280604AbRKBIsx>; Fri, 2 Nov 2001 03:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280603AbRKBIsd>; Fri, 2 Nov 2001 03:48:33 -0500
Received: from smtp-rt-1.wanadoo.fr ([193.252.19.151]:41682 "EHLO
	anagyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S280602AbRKBIs0>; Fri, 2 Nov 2001 03:48:26 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Williams <broadcast@earthling.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: crash in smp_core99_kick_cpu
Date: Fri, 2 Nov 2001 09:48:10 +0100
Message-Id: <20011102084810.8990@smtp.wanadoo.fr>
In-Reply-To: <3BE09769.2060703@earthling.net>
In-Reply-To: <3BE09769.2060703@earthling.net>
X-Mailer: CTM PowerMail 3.0.9 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is a dual CPU G4.  Startup freezes after
>
>smp_core99_kick_cpu done
>
>is displayed.  Commenting out the
>
>KL_GPIO_OUT(reset_io, KEYLARGO_GPIO_OUTPUT_ENABLE);
>
>line in feature_core99_kick_cpu allows the boot process to
>continue but with only CPU #0 and a "Processor 1 is stuck"
>message.
>
>MacOS 9.2 booted fine and detected both CPUs.
>
>Compiler gcc 2.96
>Kernel 2.4.13
>
>Kernels compiled with gcc 3.0.2 just crash and go into
>open firmware.
>
>cat /proc/cpuinfo displays

Which kernel ? Linus 2.4.13 or one of the PPC bk trees ?

I've been using 2.4.13 from bk _devel on a dual G4 for some
time now, it just worked. I'm away from my dev. machines for
a few days, but I'll look into this problem as soon as I'm
back.

gcc 3.0.2 isn't ready for ppc kernel compiles afaik. I'm
personally still using 2.95.4 from debian "sid".

Ben.


