Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261667AbREURi3>; Mon, 21 May 2001 13:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbREURiT>; Mon, 21 May 2001 13:38:19 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:25869 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S261667AbREURiC>; Mon, 21 May 2001 13:38:02 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: esr@thyrsus.com
cc: David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Message-ID: <86256A53.0060ACF6.00@smtpnotes.altec.com>
Date: Mon, 21 May 2001 12:36:48 -0500
Subject: Re: Background to the argument about CML2 design philosophy
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/21/2001 at 05:04:40 AM esr@thyrsus.com wrote:

>See, I've already written off the chronic bellyachers.  Since I can't
>please them without scrapping the whole plan, I'm going to ignore
>them.  In particular, anybody who repeated "fsck Python..." after Linus
>ruled that Python is not an issue and Greg Banks announced the C
>implementation of CML2 has got a sufficiently severe case of
>rectocranial insertion that they've defined themselves out of the
>conversation.

I probably qualify as one of the bellyachers.  If so, I apologize.  It was not
my intention to disparage the work of Eric or anyone else involved in this
project.

Speaking from the perspective of a user of the CML tools, rather than as a
developer, all I've been trying to say is this:  When I type "make menuconfig"
or "make oldconfig" in the future, I want to see the same interface and the same
results that I've always seen, because it's always worked for me in the past.
It really doesn't matter to me if, down underneath, this is being done by CML1,
CML2, or a little man in my computer who slaughters chickens and reads their
entrails for omens to determine dependencies.  Right now I can grab a new -pre
or -ac patch, use oldconfig, and have a compile going in a few minutes, without
knowing or caring about the details of the config process.  In the rare case
that a patch breaks an existing driver, it takes only a couple of minutes with
menuconfig to disable that driver and compile without it, and then put it back
in when it's fixed.  And when, every once in a great while, I decide to scrap my
.config and start over, I can fly through all the menuconfig options very
quickly and make my customary selections almost without thinking about it.

I just want to be able to keep using the tools in this way.  If that's not going
to be possible... well, I'll adapt.  But from my point of view, learning a new
set of tools just to keep doing the same things I've always done isn't a
pleasant prospect.  I understand that changes may be necessary to meet others'
needs, but I'd like to see those changes made without affecting the way my own
needs are met.

I'm off my soapbox now and won't bellyache about it any further.

Wayne


