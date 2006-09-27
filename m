Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030758AbWI0UWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030758AbWI0UWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030760AbWI0UWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:22:39 -0400
Received: from www.osadl.org ([213.239.205.134]:9433 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030758AbWI0UWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:22:38 -0400
Subject: Re: [RFC] exponential update_wall_time
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: john stultz <johnstul@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060927200832.GB20282@elte.hu>
References: <1159385734.29040.9.camel@localhost>
	 <20060927200832.GB20282@elte.hu>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 22:24:19 +0200
Message-Id: <1159388660.9326.509.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-27 at 22:08 +0200, Ingo Molnar wrote:
> * john stultz <johnstul@us.ibm.com> wrote:
> 
> > Accumulate time in update_wall_time exponentially. This avoids long 
> > running loops seen with the dynticks patch as well as the problematic 
> > hang" seen on systems with broken clocksources.
> > 
> > This applies on top of 2.6.18-mm1
> > 
> > Signed-off-by: John Stultz <johnstul@us.ibm.com>
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> works fine and is included in 2.6.18-rt too.

Same here.

	tglx





