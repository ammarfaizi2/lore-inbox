Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbTKTCka (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTKTCk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:40:29 -0500
Received: from relay-4v.club-internet.fr ([194.158.96.115]:23205 "EHLO
	relay-4v.club-internet.fr") by vger.kernel.org with ESMTP
	id S264228AbTKTCk2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:40:28 -0500
From: pinotj@club-internet.fr
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Thu, 20 Nov 2003 03:40:27 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet2.1069296027.2246.pinotj@club-internet.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Message d'origine----
>Date: Wed, 19 Nov 2003 18:09:43 -0800
>De: Andrew Morton <akpm@osdl.org>
>A: pinotj@club-internet.fr
>Copie à: linux-kernel@vger.kernel.org
>Sujet: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
[...]
>>  Is there any thing I can do to help figure out where does the problem comes from ? 
>
>Well it's interesting that it is repeatable.
>First thing to do is to eliminate hardware failures:
>
>1: Is the oops always the same, or does the machine crash in other ways, with different backtraces?

Well, I can't check right know but seemed to be the same. I will keep the next 5 oops with same distro and make a diff to be sure.

>2: Try running memtest86 on that machine for 12 hours or more.

OK

>3: Can the problem be reproduced on other machines?

Unfortunately, I can't use any other computer for this (or I will lose some friends :-) If there was already some reports about this bug, it can be good to compare the hardware and/or environment with these others people.

>4: try a different compiler version.

I already tried gcc 3.2.3 and 3.3.1 (2.95.3 to be confirmed)

I will make the tests (1, 2 and confirmed 4) and give you the results tomorrow.

Just an idea: could it be an ACPI problem ?
I will try some boot parameters too, to be sure...

>Thanks.

Your welcome

Jerome Pinot

