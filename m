Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271279AbTG2GdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 02:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271284AbTG2GdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 02:33:06 -0400
Received: from [213.69.232.58] ([213.69.232.58]:54024 "HELO schottelius.org")
	by vger.kernel.org with SMTP id S271279AbTG2GdC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 02:33:02 -0400
Date: Tue, 29 Jul 2003 00:22:17 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       GPM Mailing List <gpm@arcana.linux.it>
Subject: Re: psmouse: synaptics (2.6.0-test1|2)
Message-ID: <20030728222217.GD10741@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Peter Osterlund <petero2@telia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	GPM Mailing List <gpm@arcana.linux.it>
References: <20030728081832.GA453@schottelius.org> <m265lmihw2.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <m265lmihw2.fsf@telia.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux pinguin-02 2.4.18
X-Free86: doesn't compile currently
X-Replacement: please tell me some (working)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund [Mon, Jul 28, 2003 at 09:13:49PM +0200]:
> Nico Schottelius <nico-kernel@schottelius.org> writes:
> > My questions:
> >    3) how can I read /dev/misc/psaux in Linux 2.6 ?
> 
> AFAIK, you can't.

that could be a problem..

> >    1) why are you implementing drivers in the kernel?
> 
> Because the raw psaux device is no longer exposed to user space.

means we _are_ obsoleted from now on...
if that's true I'll try to help you to use code from gpm where possible.
and I hope we can work together so we can use gpm once again.
(and possibly develop a buffer, which is available within
gpm and X...I am rethinking this currently)

> >    2) what source of information do you use to program them?
> 
> The synaptics touchpad interfacing guide. I think this link is still valid:
> 
>         http://www.synaptics.com/decaf/utilities/ACF126.pdf

think so, too. but in fact as my dmesg shows, the touchpad doesn't
like you..and I would like to use it :)
So, is /dev/input/mice now the general device to use?
If yes, is it imps2 or what should we talk to it?

> >    3.1) howto get gpm running?
> 
> You have to hack gpm to add support for the 2.6 kernel driver.

...another brick in the .. another hack in gpm.

> Until
> someone fixes gpm you have to use the "psmouse_noext=1" module  option.

good hint, at least somehow I can work with X & gpm..

> 
> >    3.2) is the patch mentioned for X implemented in X cvs?
> 
> No, not currently. Aside from technical considerations, there is also
> a license problem, because the synaptics driver is GPL:ed, which is
> not compatible (I think) with the license used by XFree86.

Btw, aren't there any 'real' alternatives to xfree86?

> This means
> that all copyright holders for the synaptics driver need to agree to
> change the license, or their contributions have to be removed and
> reimplemented.

...or xfree86 people have to change to gpl...

good evenin'

Nico

-- 
echo God bless America | sed 's/.*\(A.*$\)/Why \1?/'
pgp: new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new
