Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbUJ0Nbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUJ0Nbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbUJ0Nbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:31:39 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:47254 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262435AbUJ0N3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:29:43 -0400
Subject: Re: Strange IO behaviour on wakeup from sleep
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <1098882498.9497.17.camel@gaston>
References: <1098845804.606.4.camel@gaston>
	 <Pine.LNX.4.53.0410271308360.9839@gockel.physik3.uni-rostock.de>
	 <1098878790.9478.11.camel@gaston>
	 <1098882118.4097.10.camel@desktop.cunninghams>
	 <1098882498.9497.17.camel@gaston>
Content-Type: text/plain
Message-Id: <1098883255.4097.12.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 27 Oct 2004 23:20:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Wed, 2004-10-27 at 23:08, Benjamin Herrenschmidt wrote:
> On Wed, 2004-10-27 at 23:01 +1000, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Wed, 2004-10-27 at 22:06, Benjamin Herrenschmidt wrote:
> > > The problem has been observed on ppc, while this patch only affects
> > > i386...
> > 
> > Another shot in the dark....
> > 
> > Nothing interesting about /proc/interrupts?
> 
> Nope, looked already, interrupts seem to flow normally... the box works,
> there are no errors or lost interrupts, it's just that disk IOs are
> _extremely_ slow...

One more, if I may... no processes sucking CPU? (That would indicate a
thread not properly handled by the refrigerating).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

