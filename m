Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288930AbSATTCJ>; Sun, 20 Jan 2002 14:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288932AbSATTCA>; Sun, 20 Jan 2002 14:02:00 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:6412 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S288930AbSATTBu>;
	Sun, 20 Jan 2002 14:01:50 -0500
Date: Sun, 20 Jan 2002 01:08:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, arjan@fenrus.demon.nl,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020120000817.GA31124@elf.ucw.cz>
In-Reply-To: <005b01c19b9e$90a5af40$0501a8c0@psuedogod> <E16PUSi-00032N-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16PUSi-00032N-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > hardware to hardware could have a higher priority than normal programs being
> > run.   That way they're not preempted by simple programs, it would have to
> > be purposely preempted by the user.
> 
> How do you know they are there. How do you detect the situation, or do you
> plan to audit every driver ?

Any driver which depends on timing is broken. 2.4.9 was happy to spend
two seconds in interrupt (console switch). So I doubt too much drivers
are broken like that. 

And... The drivers were broken already. That is not reason against the
patch!
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
