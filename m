Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276474AbRJKOc6>; Thu, 11 Oct 2001 10:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276384AbRJKOct>; Thu, 11 Oct 2001 10:32:49 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:42542 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S276381AbRJKOcn>; Thu, 11 Oct 2001 10:32:43 -0400
Date: Thu, 11 Oct 2001 16:32:54 +0200
From: Cliff Albert <cliff@oisec.net>
To: Cristian CONSTANTIN <constantin@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scsi/hdd problem...
Message-ID: <20011011163254.B18508@oisec.net>
Mail-Followup-To: Cristian CONSTANTIN <constantin@fokus.gmd.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011011160628.D29704@terix.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011011160628.D29704@terix.fokus.gmd.de>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 04:06:28PM +0200, Cristian CONSTANTIN wrote:

Same problem appeared here, seems to be a faulty firmware of my Quantum drive. As you have a IBM drive look for firmware upgrades, maybe it helps :) Also try a boot with aic7xxx=verbose as a kernel-parameter.


> scsi gurus please help! today my kernel barked like:
> 
> Oct 11 15:05:07 terix kernel: Recovery code sleeping
> Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): Abort Tag Message Sent
> Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): SCB 116 - Abort Tag Completed.
> Oct 11 15:05:07 terix kernel: Recovery SCB completes
> Oct 11 15:05:07 terix kernel: Recovery code awake
> Oct 11 15:05:07 terix kernel: aic7xxx_abort returns 8194
> Oct 11 15:05:07 terix kernel: scsi0:0:3:0: Attempting to queue an ABORT message
> Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): Queuing a recovery SCB
> Oct 11 15:05:07 terix kernel: scsi0:0:3:0: Device is disconnected, re-queuing SCB
> Oct 11 15:05:07 terix kernel: Recovery code sleeping
> Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): Abort Tag Message Sent
> Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): SCB 107 - Abort Tag Completed.
> Oct 11 15:05:07 terix kernel: Recovery SCB completes
> Oct 11 15:05:07 terix kernel: Recovery code awake
> Oct 11 15:05:07 terix kernel: aic7xxx_abort returns 8194
> Oct 11 15:05:07 terix kernel: scsi0:0:3:0: Attempting to queue an ABORT message
> Oct 11 15:05:07 terix kernel: (scsi0:A:3:0): Queuing a recovery SCB
> Oct 11 15:05:07 terix kernel: scsi0:0:3:0: Device is disconnected, re-queuing SCB
> 
> and the machine froze for a couple of minutes. in short I have
> a Tyan motherbaord with Athlon SMP support and ADAPTEC SCSI onboard, 
> kernel version :
> 
> 2.4.10-xfs #1 SMP Wed Sep 26 09:44:28 CEST 2001 i686 unknown

<-- BIG SNIP -->

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
