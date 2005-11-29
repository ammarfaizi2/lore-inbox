Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVK2QWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVK2QWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVK2QWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:22:36 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:15499 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S1751395AbVK2QWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:22:36 -0500
Date: Tue, 29 Nov 2005 17:21:06 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Nathan Scott <nathans@sgi.com>
Cc: John Hawkes <hawkes@sgi.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: unable to use dpkg 2.6.15-rc2
Message-ID: <20051129162106.GA5002@dreamland.darkstar.lan>
References: <20051121100820.D6790390@wobbly.melbourne.sgi.com> <20051122172027.GA11219@dreamland.darkstar.lan> <20051122214443.GA781@frodo> <20051128002350.GC841@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128002350.GC841@frodo>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Mon, Nov 28, 2005 at 11:23:50AM +1100, Nathan Scott ha scritto: 
> On Wed, Nov 23, 2005 at 08:44:43AM +1100, Nathan Scott wrote:
> > On Tue, Nov 22, 2005 at 06:20:27PM +0100, Luca wrote:
> > > (please CC me, I'm not subscribed)
> > > 
> > > Nathan Scott <nathans@sgi.com> ha scritto:
> > > >> It's reproducible in 2.6.15-rc1, 2.6.15-rc1-mm1, 2.6.15-rc1-mm2 and
> > > >> 2.6.15-rc2.
> > > >> 
> > > >> It does not occur in 2.6.14.
> > > >> 
> > > >> Most easily triggered by "make clean" in the Linux source, for those of
> > > >> you without access to dpkg. But both clean and dpkg will trigger it.
> > > > 
> > > > So far I've not been able to reproduce this; I'm using "make clean"
> > > > and it works just fine for me (I'm using the current git tree).
> > > 
> > > Confirmed here with 2.6.15-rc1 an IDE disk. Kernel is UP with
> > > CONFIG_PREEMPT and 8KB stack. The following debug options are enabled:
> > > 
> > 
> > Keith Owens has managed to reproduce this locally, and has been
> > working on tracking it back to a single change - so, we'll start
> > trying to figure out whats gone wrong here shortly, and will get
> > a fix merged as soon as we can.
> 
> FYI - this problem is now fixed in Linus' current git tree.

Great, I'll give it a try ASAP. BTW why using a macro instead of an
inline function makes any difference? I don't understand...

Luca
-- 
Home: http://kronoz.cjb.net
"Su cio` di cui non si puo` parlare e` bene tacere".
 Ludwig Wittgenstein
