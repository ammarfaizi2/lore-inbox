Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSHGHvZ>; Wed, 7 Aug 2002 03:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317283AbSHGHvZ>; Wed, 7 Aug 2002 03:51:25 -0400
Received: from h-64-105-137-176.SNVACAID.covad.net ([64.105.137.176]:37039
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317282AbSHGHvZ>; Wed, 7 Aug 2002 03:51:25 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 7 Aug 2002 00:54:54 -0700
Message-Id: <200208070754.AAA08086@adam.yggdrasil.com>
To: nick.orlov@mail.ru
Subject: Re: [PATCH] pdc20265 problem.
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Orlov writes:
>But wouldn't it be a cleaner solution if we will have _compile_ time
>option that by default is turned on in order to handle rare cases,
>and _can_ be turned off in order to handle _most_ cases without any
>boot-time options?

	You might not see them on linux-kenrel, but there are
lots of Linux users that are not comfortable compiling a custom
kernel (or even competent to do so), but are a bit more willing
to edit files and rerun a boot configuration utility like lilo.

	Linux users in the "I'm not a sysadmin" crowd (?) probably
don't care about the scan order of the pdc20265 IDE controller,
but people in the "I'm a sysadmin, not a programmer" crowd
may have legitimiate reasons to.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
