Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292585AbSBPWpz>; Sat, 16 Feb 2002 17:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292586AbSBPWpp>; Sat, 16 Feb 2002 17:45:45 -0500
Received: from hera.cwi.nl ([192.16.191.8]:51330 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S292585AbSBPWpa>;
	Sat, 16 Feb 2002 17:45:30 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 16 Feb 2002 22:45:26 GMT
Message-Id: <UTC200202162245.WAA31932.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com
Subject: Re: [PATCH] size-in-bytes
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From dalecki@evision-ventures.com Sat Feb 16 23:05:50 2002

    Well I see that you have killed all places where it get's used - that's 
    fine!
    But why don't just kill (fix) the initializations as well. You have already:

    g->part[minor(dev)].nr_sects;

    and friends right there at your hands ;-).

Yes, of course there is a reason this patch is called 02*.
I planned a road to happiness in 92 steps, where each of the steps
does something clear and simple, simplifies the tree, beautifies
the code, restructures in a clearly necessary way.
Indeed, your suggested steps are also there.
Five or six of these steps found their way into the kernel,
(some thanks to Christoph Hellwig) but there is still a long way to go.
The present patch is just a rediff of step 02.

I do not know what the best strategy is, these times.
I see you and Vojtech do good things to the IDE code,
but would myself prefer to do such things in a series
of really small steps. That way it is also very clear
for Andre what happens.

Andries
