Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQKJLAn>; Fri, 10 Nov 2000 06:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbQKJLAd>; Fri, 10 Nov 2000 06:00:33 -0500
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:27657 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S129199AbQKJLAW>; Fri, 10 Nov 2000 06:00:22 -0500
Date: Fri, 10 Nov 2000 10:52:13 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001110105213.A18736@bart.dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Michal Jaegermann <michal@harddata.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <3A0977A7.53641C52@mandrakesoft.com> <20001108113859.A10997@animx.eu.org> <3A098594.A85DFE0D@mandrakesoft.com> <20001108122306.A11107@animx.eu.org> <3A0989CC.2537FCEA@mandrakesoft.com> <20001109113347.B14133@animx.eu.org> <20001109163124.A31909@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001109163124.A31909@mail.harddata.com>; from michal@harddata.com on Thu, Nov 09, 2000 at 04:31:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 04:31:24PM -0700, Michal Jaegermann wrote:
> On Thu, Nov 09, 2000 at 11:33:47AM -0500, Wakko Warner wrote:
> > > It was posted to lkml, so no link (except if you want to dig through
> > > lkml mail archives).
> > 
> > It booted but then it oops'ed before userland I belive.  I tried it this
> > morning and didn't have much time.  It did find the scsi controller (which
> > is across the bridge) and the drives attached so it does appear to be
> > working.
> 
> Looks so far that I am the worst off.  If I am trying to boot with
> a root on a SCSI device then either a controller is misdetected,
> or goes into an infinite "abort/reset" loop, or it does not initialize
> properly and disks are not found.  This is a non-exclusive, logical,
> "or". :-)

<metoo>Me too!</metoo>

Exact same symptoms on my ruffian.

Sean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
