Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUFFJBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUFFJBf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 05:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUFFJBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 05:01:32 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:15034 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263154AbUFFJB3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 05:01:29 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Vojtech Pavlik <vojtech@suse.cz>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
References: <20040604135816.GD11950@elf.ucw.cz>
	<200406041817.i54IHFgZ004530@eeyore.valparaiso.cl>
	<20040604183944.GK700@elf.ucw.cz>
	<xb78yf317r0.fsf@savona.informatik.uni-freiburg.de>
	<20040604190947.GM700@elf.ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
In-Reply-To: <20040604190947.GM700@elf.ucw.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 06 Jun 2004 11:01:23 +0200
Message-ID: <xb71xkt12n0.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@suse.cz> writes:

    >> If you can arrange bash to be run, then why is it that
    >> difficult to arrange "modprobe atkbd; modprobe i8042" to be
    >> executed?

    Pavel> It would not be "modprobe atkbd" but "my-keyboard-daemon
    Pavel> &". 

What's the  difference?  Both  are commands.  Commands  can be  put in
shell scripts, which can be put in shell scripts, ...  Eventually, you
only need one root script to spawn all the offsprings.



    Pavel> And AFAIK you can't add that to "init=" commandline.

That's  getting  funny.   You  can't   start  6  copies  of  getty  on
/dev/tty[1-6] on "init=", can you?


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

