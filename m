Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277270AbRJEAAc>; Thu, 4 Oct 2001 20:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277276AbRJEAAN>; Thu, 4 Oct 2001 20:00:13 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:24258 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S277270AbRJEAAJ>;
	Thu, 4 Oct 2001 20:00:09 -0400
Message-ID: <3BBCF802.1B650B20@candelatech.com>
Date: Thu, 04 Oct 2001 17:00:02 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Robert Love <rml@tech9.net>, Benjamin LaHaise <bcrl@redhat.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>, mingo@elte.hu,
        jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, netdev@oss.sgi.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110041650410.975-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On 4 Oct 2001, Robert Love wrote:
> >
> > Agreed.  I am actually amazed that the opposite of what is happening
> > does not happen -- that more people aren't clamoring for this solution.
> 
> Ehh.. I think that most people who are against Ingo's patches are so
> mainly because there _is_ an alternative that looks nicer.
> 
>                 Linus

The alternative (NAPI) only works with Tulip and Intel NICs, it seems.
When the alternative works for every driver known (including 3rd party
ones, like the e100), then it will truly be an alternative.  Untill
then, it will be a great feature for those who can use it, and the
rest of the poor folks will need a big generic hammer.

>From personal experince, I imagine the problem is also that it was
not invented here, where here is where each of sit.  And I include
myself in that bias!

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
