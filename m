Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbTAAWYV>; Wed, 1 Jan 2003 17:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTAAWYV>; Wed, 1 Jan 2003 17:24:21 -0500
Received: from mail-fe73.tele2.ee ([212.107.32.238]:29356 "HELO everyday.com")
	by vger.kernel.org with SMTP id <S265012AbTAAWYU>;
	Wed, 1 Jan 2003 17:24:20 -0500
Date: Thu, 2 Jan 2003 00:32:44 +0200
Message-Id: <200301012232.h01MWiW00474@mail-fe2.tele2.ee>
To: Andi Kleen <ak@muc.de>
Subject: Re: 3rdparty modules for 2.5.53
From: Albert Kajakas <Albert.Kajakas@mail.ee>
X-Mailer: www.mail.ee
X-Login-From: 80.235.70.104::
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks!

it i postponed development for weeks just because i switched to 2.5 and i couldn't solve the stupid problem.


al.
>Albert Kajakas <Albert.Kajakas@mail.ee> writes:
>
>> Hello!
>> I have a problem with compiling modules for 2.5.
>
>I recently tracked down the same problem.
>
>Add a -DKBUILD_MODNAME="yourname" compile option to one of the files,
>the new loader requires a module name section. It should be only set
>once for each module.
>
>In addition make sure you're using the new style module_init/module_exit
>macros instead of init_module/cleanup_module.
>
>-Andi
>
>P.S.: I agree that the error reporting sucks for this one. It would
>be better if the kernel loader give some kind of text message back.
>
>

-- everyday.com --
Kuidas elad, Eesti tudeng? 
Osale Tõnis Paltsu esseekonkursil üliõpilastele, 
auhinnafond 10 000 kr. http://www.palts.ee/?id=756
Häid pühi soovides, Tõnis Palts


