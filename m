Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWFZH6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWFZH6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 03:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWFZH6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 03:58:09 -0400
Received: from www.osadl.org ([213.239.205.134]:14001 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932391AbWFZH6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 03:58:07 -0400
Subject: Re: Problem with 2.6.17-mm2
From: Thomas Gleixner <tglx@linutronix.de>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: logcheck@knarzkiste.dyndns.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       root@knarzkiste.dyndns.org
In-Reply-To: <20060626074432.GR4052@charite.de>
References: <20060626074226.7B251E0035AE@knarzkiste.dyndns.org>
	 <20060626063706.38642E006A89@knarzkiste.dyndns.org>
	 <20060625103523.GY27143@charite.de> <20060625034913.315755ae.akpm@osdl.org>
	 <20060625105512.GZ27143@charite.de>
	 <1151250115.25491.384.camel@localhost.localdomain>
	 <20060626074432.GR4052@charite.de>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 09:58:06 +0200
Message-Id: <1151308686.7552.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 09:44 +0200, Ralf Hildebrandt wrote:
> * Thomas Gleixner <tglx@linutronix.de>:
> 
> > Can you please provide the boot log from 2.6.17 and one with the
> > following patch on top of 2.6.17-mm2 applied:
> > http://www.tglx.de/private/tglx/linux-2.6.17-mm2-revert-genirq.diff
> 
> See the two logs below.
>  
> > It reverts the genirq changes. When the unexpected IRQ trap messages
> > persist, we know that it's unrelated to genirq. Otherwise, sigh
> 
> They seem to be gone...

Ralf,

thanks for testing. We found the reason for this yesterday night.

	tglx


