Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVHCPVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVHCPVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 11:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVHCPVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 11:21:54 -0400
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:60358 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S262310AbVHCPUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 11:20:36 -0400
Date: Wed, 03 Aug 2005 11:20:29 -0400
From: ambx1@neo.rr.com
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: James Bruce <bruce@andrew.cmu.edu>, David Weinehall <tao@acc.umu.se>,
       Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@ucw.cz>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Message-id: <dbb91149e.1149edbb9@columbus.rr.com>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 2.04 (built Feb  8 2005)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
From: Theodore Ts'o <tytso@mit.edu>
Date: Monday, August 1, 2005 4:42 pm
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers

> On Mon, Aug 01, 2005 at 12:18:18PM -0400, James Bruce wrote:
> > 
> > The tradeoff is a realistic 4.4% power savings vs a 300% increase 
> in the 
> > minimum sleep period.  A user will see zero power savings if they 
> have a 
> > USB mouse (probably 99% of desktops).  On top of that, we can 
> throw in 
> > Con's disturbing AV benchmark results (1).  As a result, some of 
> us 
> > don't think 250HZ is a great tradeoff to make 
> _for_the_default_value_.
> Most laptops (including mine, a Thinkpad T40) use a PS/2 mouse.  So in
> the places where power consumption savins matters most, it's usually
> quite possible to function without needing any USB devices.  The 90%
> figure isn't at all right; in fact, it may be that over 90% of the
> laptops still use PS/2 mice and keyboards.
> 
>                                        	- Ted

Also, my understanding was that when we properly support usb suspend,
this won't be an issue anyway for much usb hardware.  I think it's
possible to put some mice to sleep when there isn't any motion and
then wakeup later.

4.4% savings may not be much, but these things do add up.  For a
laptop's workload, I think this is worth it.

Thanks,
Adam

