Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSEaDbB>; Thu, 30 May 2002 23:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSEaDbA>; Thu, 30 May 2002 23:31:00 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:9156 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S314514AbSEaDa7>; Thu, 30 May 2002 23:30:59 -0400
From: "Hua Zhong" <hzhong@cisco.com>
To: "Kenneth Johansson" <ken@canit.se>,
        "Daniel Phillips" <phillips@bonn-fries.net>
Cc: "Keith Owens" <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: RE: KBuild 2.5 Impressions
Date: Thu, 30 May 2002 20:29:11 -0700
Message-ID: <FEEFKBEFIEBONNKJABKDOEIKDKAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1022803993.2799.13.camel@tiger>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch size accusation is kinda rediculous to me. Linus _does_ accept
large patches -
remember the whole VM switchover? The ALSA patch, as another example?  And I
bet
whenever there is a new file system the patch must be huge. Why aren't they
split
up? How does it sound, "let's ask Andrea to split up his VM patches so that
they
gradually improve Rik's VM"? (no offense to Andrea) If such a big change in
such a critical
subsystem is allowed, why not kbuild 2.5?

Sometimes it just doesn't make sense to split up things if they need to work
_together_,
especially when you want to _replace_ something instead of improving it.
Well, you could
split it up into many small patches, but if they must be applied together
how much good would that
give you? To me it's just like "well, since they asked let's do it just to
make _them_ happy
so the damn thing can get in".

Auh..the "only Keith could fix things"....come'on, isn't this open-source?
Hey, You guys are genius,
and I don't believe at all a build system is more complex than any piece of
the kernel itself. And look at
the VM change during 2.4 (sorry to mention it again), how about "only Andrea
could fix bugs in the new
VM"? That still happened, although there was far less documentation of the
new VM than that of kbuild 2.5.

I have to say I don't see good reasons to set up obstacles to Keith's work.
It's faster, it's more reliable,
it coexists with the current build system, and it's been well tested. What
else to ask for? Let's just get it
in and  be done with it, so people can spend time on more useful things. (I
have a feeling that if Linus
actually does this, all the accusations will go away, so all the questions
boil down to: what does Linus
think/do? :-)

I'm not an active kernel hacker (although I do work on Linux and writing
kernel modules is part of my job),
so my opinion may not count, but I can't help on this.

regards,

Hua

> Maybe I'm the idiot here but what dose this gain you??
>
> The reason to break up a patch is not simply to get more of them. There
> is no point in splitting if you still need to use every single one of
> them to make anything work.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

