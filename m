Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVFAVJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVFAVJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVFAVJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:09:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44314
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261286AbVFAVH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:07:28 -0400
Date: Wed, 1 Jun 2005 23:07:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601210716.GB5413@g5.random>
References: <20050601192224.GV5413@g5.random> <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk> <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com> <20050601203212.GZ5413@g5.random> <20050601204612.GA27934@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601204612.GA27934@nietzsche.lynx.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 01:46:12PM -0700, Bill Huey wrote:
> Where ? Point it out.

Why don't you run grep yourself, this is only drivers/

./acpi/processor_idle.c:	local_irq_disable();
./acpi/processor_throttling.c:	local_irq_disable();
./acpi/processor_throttling.c:	local_irq_disable();
./block/acsi_slm.c:		local_irq_disable();
./block/ataflop.c:	local_irq_disable();		 * disabled... so must save the IPL for later */ 
./char/amiserial.c:	local_irq_disable();
./char/amiserial.c:		local_irq_disable();
./char/ds1302.c:	local_irq_disable();
./char/ds1302.c:			local_irq_disable();
./ide/ide-io.c:			local_irq_disable();
./ide/ide-taskfile.c:		local_irq_disable();
./ide/legacy/hd.c:	local_irq_disable();
./ide/legacy/hd.c:		local_irq_disable();
./input/joystick/analog.c:		local_irq_disable();
./macintosh/via-pmu.c:	local_irq_disable();
./macintosh/via-pmu.c:	local_irq_disable();
./macintosh/via-pmu.c:	local_irq_disable();
./mtd/chips/cfi_cmdset_0001.c:	local_irq_disable();
./mtd/chips/cfi_cmdset_0001.c:			local_irq_disable();
./mtd/chips/cfi_probe.c:#define xip_disable()	local_irq_disable()
./mtd/chips/cfi_util.c:	local_irq_disable();
./net/3c59x.c:	local_irq_disable();
./net/8139cp.c:		local_irq_disable();
./net/8139too.c:		local_irq_disable();
./net/amd8111e.c:	local_irq_disable();
./net/hamradio/baycom_par.c:        local_irq_disable();
./net/hamradio/baycom_ser_fdx.c:	local_irq_disable();
./net/hamradio/baycom_ser_hdx.c:	local_irq_disable();
./net/hamradio/scc.c:	local_irq_disable();
./net/pcmcia/fmvj18x_cs.c:    local_irq_disable();
./net/smc91x.c:	local_irq_disable();						\
./s390/cio/cio.c:	local_irq_disable();
./scsi/53c7xx.c:	    local_irq_disable();
./scsi/53c7xx.c:	local_irq_disable(); /* Freeze request queues */
./scsi/53c7xx.c:	    local_irq_disable();
./scsi/BusLogic.c:		local_irq_disable();
./scsi/atari_NCR5380.c:	local_irq_disable(); /* Freeze request queues */
./scsi/atari_NCR5380.c:		    local_irq_disable();
./scsi/atari_NCR5380.c:			local_irq_disable();
./scsi/scsi.c:	local_irq_disable();
./scsi/scsi.c:		local_irq_disable();
./scsi/sun3_NCR5380.c:	local_irq_disable(); /* Freeze request queues */
./scsi/sun3_NCR5380.c:		    local_irq_disable();
./scsi/sun3_NCR5380.c:			local_irq_disable();
./serial/68360serial.c:	local_irq_disable();
./serial/68360serial.c:	local_irq_disable();
./serial/68360serial.c:	local_irq_disable();
./serial/68360serial.c:	local_irq_disable();
./serial/68360serial.c:	local_irq_disable();
./serial/68360serial.c:			local_irq_disable();
./serial/68360serial.c:				local_irq_disable();
./serial/68360serial.c:			local_irq_disable();
./serial/68360serial.c:		local_irq_disable();
./serial/68360serial.c:		local_irq_disable();
./serial/68360serial.c:	local_irq_disable();
./serial/68360serial.c:		local_irq_disable();
./serial/68360serial.c:	local_irq_disable();
./serial/mcfserial.c:		local_irq_disable();		
./serial/mcfserial.c:		local_irq_disable();
./serial/mcfserial.c:	local_irq_disable();
./serial/mcfserial.c:		local_irq_disable();
./usb/core/hcd.c:	local_irq_disable ();
./usb/gadget/inode.c:	local_irq_disable();
./usb/gadget/pxa2xx_udc.c:	local_irq_disable();
./usb/gadget/pxa2xx_udc.c:	local_irq_disable();
./usb/gadget/pxa2xx_udc.c:	local_irq_disable();
./video/aty/radeon_base.c:	local_irq_disable();

> Long paths are audited and correct when instrumentation is triggered
> by it. Look at the patch.

As said even if all the above is audited, it _can_ break over time,
while it wouldn't break with RTAI/rtlinux even if you infinite loop and
hang in there.

> Doesn't have to yet. Drivers are case by case problem as expected. Look
> at the patch.

The "case by case" appoach is the problem, so that you plug an usb
gadget in, and your robot breaks and damages stuff. That would never
happen with RTAI/rtlinux. (ok, a bad driver could corrupt memory anyway,
but introducing a latency problem is much easier than introducing a
memory corruption)

> Wrong. I did a parallel implementation of this patch and I understand
> the issues very clearly. Deterministic single kernel RT isn't new or
> novel in the RTOS world (LynxOS, SGI IRIX, ...).

Don't change topic, you said local_irq_disable isn't smp safe in
drivers...

> Listen to what Ingo, me and others have said and read the patch. You're

Ingo just said that making local_irq_disable a "soft-cli" is planned.

> into the patch. Really, read the patch and stop asking question, spreading
> FUD until then.

You're the one spreading FUD that preempt-RT is as good as RTAI, and
even worse than local_irq_disable isn't used in drivers or not safe to
use in smp.
