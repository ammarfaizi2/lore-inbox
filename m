Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275078AbRJJIFv>; Wed, 10 Oct 2001 04:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRJJIFl>; Wed, 10 Oct 2001 04:05:41 -0400
Received: from 157-151.nwinfo.net ([216.187.157.151]:898 "EHLO
	mail.morcant.org") by vger.kernel.org with ESMTP id <S275078AbRJJIFa>;
	Wed, 10 Oct 2001 04:05:30 -0400
Message-ID: <32879.24.255.76.12.1002701163.squirrel@webmail.morcant.org>
Date: Wed, 10 Oct 2001 01:06:03 -0700 (PDT)
Subject: Tainted Modules Help Notices
From: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    After compiling 2.4.11 I noticed modprobe picking up some of the tainted modules that
 were marked in the update.

    What surprised me was the PPP compression modules, I didn't use PPP in 2.4.10 so maybe
the notice was there in 2.4.10, but I didn't use them so I didn't see it. I shouldn't have
been surprised, but I was. BSD compression, BSD license... doh... :>

    I do however at times use the nls modules, and I see a great deal of them are BSD-NAC
licensed. It's also nice to have ipchains_core laying around for compatibility at times as
well. If I had known this at compile time I would have opted not to compile them, as
modules or otherwise. Knowing now that there are modules in the kernel build tree that are
not GPLed, and since I don't know which ones, I will grep for MODULE_LICENSE first from
now on.

    After this discovery, I would like to ask opinions on including licensing terms in
item/module help files. It would be very convient if under dpt_i2o help it said that it
was licensed under BSD-NAC.

-- 
Morgan Collins [Ax0n] http://sirmorcant.morcant.org
Software is something like a machine, and something like mathematics, and something like
language, and something like thought, and art, and information.... but software is not in
fact any of those other things.

