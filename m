Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVAKWxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVAKWxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVAKWuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:50:04 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:54250 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262876AbVAKWqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:46:23 -0500
Message-Id: <200501112245.j0BMjUTn006904@localhost.localdomain>
To: Matt Mackall <mpm@selenic.com>
cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Tue, 11 Jan 2005 11:50:10 PST."
             <20050111195010.GU2940@waste.org> 
Date: Tue, 11 Jan 2005 17:45:30 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.197.39.54] at Tue, 11 Jan 2005 16:46:16 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thankfully a buffer underrun is no more fatal for pro audio than a
>broken guitar string. CDs skip, DATs glitch, XLR cables flake out,
>circuit breakers trip, amps clip, Powerbooks crash, and the show goes
>on. I've done more than enough stage tech to know it's a huge pain in
>the ass, but let's stop pretending we require absolute perfection,
>please.

Are you really serious? Nobody said anything about absolute
perfection. We've got 2 kernels (2.4+lowlat, and 2.6
+realtime_preempt) whose performance *far* exceeds that of any vanilla
kernel, and in the latter case, probably any other desktop OS. We've
even got a kernel (2.6.9 or maybe .10) whose performance is getting
closer to par with OSX. We want people to be able to access this
performance relatively hassle free. Right now, people who want this
have to jump through a lot of hoops to access something they can, and
should, be able to do quite easily.

*That* is what this is all about, nothing more. From the looks of
things, the performance of vanilla 2.6 in this area is going to
continue to improve, but users' ability to actually use it will remain
in the same primitive condition its in now.

--p




