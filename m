Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTKQUfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbTKQUfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:35:45 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:25358 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S261411AbTKQUfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:35:43 -0500
Date: Mon, 17 Nov 2003 21:35:33 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Matrox Acceleration Probably_Just_Cosmetic Bug
Message-ID: <20031117203533.GA6727@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <3FB75569.6040408@tudorejo.org> <20031117194845.GC18448@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117194845.GC18448@vana.vc.cvut.cz>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Vandrovec <vandrove@vc.cvut.cz>
Date: Mon, Nov 17, 2003 at 08:48:45PM +0100
> On Sun, Nov 16, 2003 at 09:46:01PM +1100, Tudor wrote:
> > If you select "Matrox Acceleration" either built in or as module there 
> > are two options:
> > - G100/G200/G400/G450/G500 support
> > and
> > - G100/G200/G400 support
> > 
> > If you select the first, the second disappears.
> > If you select the second, the first stays.
> 
> It is feature, so you can "extend" your driver later when you decide. Both
> config options points to the same sources. In the past there was option
> "G100-G550 support" with "Secondary head on G450/G550". Unfortunately 
> G450 and G550 users were connecting monitor to the secondary output,
> and then complaining that they do not see anything on the monitor.
> So now this option is implicitly enabled when you select first choice,
> and disabled when you select second one.
> 
> Unless you cannot afford about 16KB for secondary CRTC driver, you should
> select first choice, as it gives you better upgrade path.
> 							Petr Vandrovec
> 
I've always found this confusing as well, as I use a G450 but never use
the secondary output.

How about

- G100-550 support (including secondary output)
- G100-400 support (single head only)

then mention in the help-text that secondary output is only usable after
running program %%%% ?

Jurriaan
-- 
She opened her eyes and gazed bleakly at him. "And is it your idea that
discussing this interesting subject will make us friends?"
	Guy Gavriel Kay - Tigana
Debian (Unstable) GNU/Linux 2.6.0-test9-mm3 4259 bogomips 0.16 0.11
