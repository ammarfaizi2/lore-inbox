Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbREVK67>; Tue, 22 May 2001 06:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbREVK6t>; Tue, 22 May 2001 06:58:49 -0400
Received: from [195.6.125.97] ([195.6.125.97]:4881 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S261289AbREVK6h>;
	Tue, 22 May 2001 06:58:37 -0400
Date: Tue, 22 May 2001 12:53:51 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: [newbie] timer in module
Message-Id: <20010522125351.447518e8.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Début du message transféré :

Date: Tue, 22 May 2001 11:39:30 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: Bart Trojanowski <bart@jukie.net>
Subject: Re: [newbie] timer in module (fwd)


Le Mon, 21 May 2001 19:35:25 -0400 (EDT)
Bart Trojanowski <bart@jukie.net> a ecrit :

> 
> this was my first post on this thread.
> 
> I did miss one call and that was add_timer(), after that you can call
> mod_timer to change the next time the timer fires.

ok, to using mod_timer we must hace already used one time  add_timer ?

> Let me know if you need anything else.

So I've succeed to use a timer but with the struct timer_list.
I've found some example in rubini's book [oreilly], but I'm not sure
if the declaration of timer must be global ?
e.g If I do a timer call in a local function, whith a timer_list struct 
local, and when the scheduler handle the timer interrupt although I am
already out of local function... what's happen (oops ?)

And also I want to ensure that I can put whatever I want in the data
field.

thanks for all your advices.

> 
> Bart.
