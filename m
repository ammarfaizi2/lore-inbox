Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265921AbUFDTKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbUFDTKC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 15:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUFDTKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 15:10:02 -0400
Received: from gprs214-121.eurotel.cz ([160.218.214.121]:2434 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265921AbUFDTJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 15:09:58 -0400
Date: Fri, 4 Jun 2004 21:09:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Vojtech Pavlik <vojtech@suse.cz>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040604190947.GM700@elf.ucw.cz>
References: <20040604135816.GD11950@elf.ucw.cz> <200406041817.i54IHFgZ004530@eeyore.valparaiso.cl> <20040604183944.GK700@elf.ucw.cz> <xb78yf317r0.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb78yf317r0.fsf@savona.informatik.uni-freiburg.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     Pavel> I know bootloader will hae its own kbd driver.
> 
>     Pavel> But when kernel boots, you'll not be able to enter commands
>     Pavel> into the bash.
> 
> Funny.  How did you type the command to start bash?

That was in comment you stripped.

> If you can  arrange bash to be  run, then why is it  that difficult to
> arrange "modprobe atkbd; modprobe i8042" to be executed?

It would not be "modprobe atkbd" but "my-keyboard-daemon &". And AFAIK
you can't add that to "init=" commandline.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
