Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313131AbSDOJeh>; Mon, 15 Apr 2002 05:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313133AbSDOJeg>; Mon, 15 Apr 2002 05:34:36 -0400
Received: from employees.nextframe.net ([212.169.100.200]:28913 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S313131AbSDOJef>; Mon, 15 Apr 2002 05:34:35 -0400
Date: Mon, 15 Apr 2002 11:34:33 +0200
From: Morten Helgesen <admin@nextframe.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  [COMMENTS IDE 2.5] - "idebus=66" in 2.5.8 results in "ide_setup: idebus=66 -- BAD OPTION"
Message-ID: <20020415113433.B181@sexything>
Reply-To: admin@nextframe.net
In-Reply-To: <20020415112332.A181@sexything> <3CBA8E70.5010605@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 10:25:20AM +0200, Martin Dalecki wrote:
> Morten Helgesen wrote:
> >Hey Martin (and the rest of you)
> 
> >Now, I do not know the reasons for changing the code that handles "idebus=" 
> >stuff in ide.c (except from the fact
> 
> Should be an off by one error there.

yep - that`s what struck me.

> 
> >that it now looks cleaner :) - just thought I should let you know. I do not 
> >have the time right now to hunt down
> >the bug(?) and cook up a patch, but if you want me to, I`ll do it later 
> >today. 
> 
> I would love if you could have a look at it...

sure - I`ll have a look at it in an hour or two.

> 
> >One more thing, Martin - I compiled a 2.5.8 with TCQ enabled (yep, I`m 
> >aware of the fact that this one is _really_ alpha :), and tested it for, oh 
> >... 10 minutes ... the system gave me all sorts of funny responses - 
> >segfaults, "inconsistency in ld.so" and so on ... would you like me to 
> >collect 'funnies' and send them to you ? If so, just give me a hint.
> 
> Thats mostly Jens stuff...

ok - Jens ? 

I forgot to mention that 2.5.8 _without_ TCQ works like a charm - that`s why I made TCQ my main suspect :)

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
