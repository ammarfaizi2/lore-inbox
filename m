Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272883AbTG3OUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272885AbTG3OUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:20:01 -0400
Received: from routeree.utt.ro ([193.226.8.102]:41671 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S272923AbTG3OTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:19:09 -0400
Message-ID: <62551.194.138.39.55.1059575083.squirrel@webmail.etc.utt.ro>
Date: Wed, 30 Jul 2003 17:24:43 +0300 (EEST)
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.44.0307280935300.4596-100000@localhost.localdomain>
References: <5.2.1.1.2.20030728093215.01be8f68@pop.gmx.net>
        <Pine.LNX.4.44.0307280935300.4596-100000@localhost.localdomain>
X-Priority: 3
Importance: Normal
Cc: <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar said:

>
> could you give -G7 a try:
>
> 	redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G7
>

For me it's worse than G2 but still good.
With vanila kernel patched with your patch (G7) on top of 2.6.0-test2
I can watch a movie while doing make -j 5 bzImage in the background

With Con Kolivas O10 (on top on 2.6.0-test2-mm1) I can't watch a
movie while doing make bzImage

Setup is the same: minimal window manager (fvwm),
a couple of processes sleeping and only make and mplayer running

>
> 	Ingo

Calin

-- 
# fortune
fortune: write error on /dev/null --- please empty the bit bucket


-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


