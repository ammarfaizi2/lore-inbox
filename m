Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUJ0NRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUJ0NRt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbUJ0NRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:17:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:50150 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262433AbUJ0NMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:12:51 -0400
Subject: Re: Strange IO behaviour on wakeup from sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@linuxmail.org
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <1098882118.4097.10.camel@desktop.cunninghams>
References: <1098845804.606.4.camel@gaston>
	 <Pine.LNX.4.53.0410271308360.9839@gockel.physik3.uni-rostock.de>
	 <1098878790.9478.11.camel@gaston>
	 <1098882118.4097.10.camel@desktop.cunninghams>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 23:08:18 +1000
Message-Id: <1098882498.9497.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 23:01 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2004-10-27 at 22:06, Benjamin Herrenschmidt wrote:
> > The problem has been observed on ppc, while this patch only affects
> > i386...
> 
> Another shot in the dark....
> 
> Nothing interesting about /proc/interrupts?

Nope, looked already, interrupts seem to flow normally... the box works,
there are no errors or lost interrupts, it's just that disk IOs are
_extremely_ slow...

Ben.


