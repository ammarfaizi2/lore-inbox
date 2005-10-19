Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbVJSXNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbVJSXNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 19:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbVJSXNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 19:13:06 -0400
Received: from p54B05293.dip.t-dialin.net ([84.176.82.147]:41160 "EHLO
	ccc-offenbach.org") by vger.kernel.org with ESMTP id S1751582AbVJSXNF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 19:13:05 -0400
Date: Thu, 20 Oct 2005 01:12:58 +0200
From: Rudolf Polzer <debian-ne@durchnull.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for local root compromise
Message-ID: <20051019231258.GA5035%atfield-dt@durchnull.de>
References: <20051018044146.GF23462@verge.net.au> <m37jcakhsm.fsf@defiant.localdomain> <20051018171645.GA59028%atfield-dt@durchnull.de> <m3fyqyhdm8.fsf@defiant.localdomain> <20051018204919.GA21286%atfield-dt@durchnull.de> <m3oe5l21rr.fsf@defiant.localdomain> <20051019132326.GA31526%atfield-dt@durchnull.de> <m3y84pjo9m.fsf@defiant.localdomain> <20051019202458.GA51688%atfield-dt@durchnull.de> <m3zmp52jyz.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <m3zmp52jyz.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scripsis, quam aut quem »Krzysztof Halasa« appellare soleo:
> Rudolf Polzer <debian-ne@durchnull.de> writes:
> > That's the only thing that might actually work - an inductive device wrapped
> > around the keyboard cable. But I've never seen those available ready to buy.
> 
> There are simpler designs - it's just a serial line, right? A simple
> "dongle" can send data from the keyboard to a notebook. With luck two
> wires would do (using parallel port for sampling data).

We use a PS/2 port, so without a reboot, this would not work. IIRC 2.6 kernels
with keyboard support compiled into the kernel cannot be forced to re-detect
the keyboard when the line was interrupted (which is a big problem with old KVM
switches). Of course, with USB keyboards this approach would work.

And if it weren't for the typical nvidia driver problems, we wouldn't allow
students to reboot the computers using the power button and let it restart the
X server instead.
