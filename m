Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUFFQlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUFFQlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUFFQlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:41:47 -0400
Received: from gprs214-225.eurotel.cz ([160.218.214.225]:34176 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263815AbUFFQlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:41:40 -0400
Date: Sun, 6 Jun 2004 18:40:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Vojtech Pavlik <vojtech@suse.cz>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040606164037.GB3582@elf.ucw.cz>
References: <20040604135816.GD11950@elf.ucw.cz> <200406041817.i54IHFgZ004530@eeyore.valparaiso.cl> <20040604183944.GK700@elf.ucw.cz> <xb78yf317r0.fsf@savona.informatik.uni-freiburg.de> <20040604190947.GM700@elf.ucw.cz> <xb71xkt12n0.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb71xkt12n0.fsf@savona.informatik.uni-freiburg.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     Pavel> And AFAIK you can't add that to "init=" commandline.
> 
> That's  getting  funny.   You  can't   start  6  copies  of  getty  on
> /dev/tty[1-6] on "init=", can you?

No, but you can do init=/bin/bash. [Are you reading my mails at all?!]
And init=/bin/bash is enough to recover broken system.

What you are proposing is incompatible update that would break 99% of
all systems, for gain of 8K of unswappable memory or something like
that. That's no-no in 2.6 series, and probably bad idea for 2.7, too.

Now, can we end the thread here? Userland keyboard driver is not going
to happen in 2.6.X.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
