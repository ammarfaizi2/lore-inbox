Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261858AbREYUjL>; Fri, 25 May 2001 16:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbREYUiw>; Fri, 25 May 2001 16:38:52 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:53933 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261840AbREYUio>; Fri, 25 May 2001 16:38:44 -0400
Date: Fri, 25 May 2001 22:38:41 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Randy <randys@evcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dedicated Interrupt handling on SMP
Message-ID: <20010525223841.V754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3B0E8B9F.CFBEAC59@evcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3B0E8B9F.CFBEAC59@evcom.net>; from randys@evcom.net on Fri, May 25, 2001 at 12:43:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 12:43:11PM -0400, Randy wrote:
> I'm trying to find the easiest way to to deidcate one CPU to responding
> to a specific Interrupt request.
> That CPU should only listen for that request while all other CPU should
> ignore the interrupt.

cat /proc/irq/*/smp_affinity

There you can select on which if the 32 CPUs Linux should handle
this IRQ.

Read Documentation/IRQ-affinity.txt for more.

Regards

Ingo Oeser
-- 
To the systems programmer,
users and applications serve only to provide a test load.
