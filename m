Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265919AbUFDSrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbUFDSrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUFDSrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:47:17 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:5034 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S265919AbUFDSq3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:46:29 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Vojtech Pavlik <vojtech@suse.cz>,
       Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
References: <20040604135816.GD11950@elf.ucw.cz>
	<200406041817.i54IHFgZ004530@eeyore.valparaiso.cl>
	<20040604183944.GK700@elf.ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 04 Jun 2004 20:46:27 +0200
In-Reply-To: <20040604183944.GK700@elf.ucw.cz>
Message-ID: <xb78yf317r0.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@suse.cz> writes:

    Pavel> I know bootloader will hae its own kbd driver.

    Pavel> But when kernel boots, you'll not be able to enter commands
    Pavel> into the bash.

Funny.  How did you type the command to start bash?

If you can  arrange bash to be  run, then why is it  that difficult to
arrange "modprobe atkbd; modprobe i8042" to be executed?


Some distros even have the disk  driver and filesystem for the root fs
compiled as modules.  They do  manage to load those modules correct to
mount the rootfs.  How come it  is so hard to imagine that 'i8042' and
'atkbd' can somehow be loaded without user attention at boot time?



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

