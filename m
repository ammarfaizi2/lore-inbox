Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312512AbSCYVcQ>; Mon, 25 Mar 2002 16:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312577AbSCYVcH>; Mon, 25 Mar 2002 16:32:07 -0500
Received: from p50846B26.dip.t-dialin.net ([80.132.107.38]:51680 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S312512AbSCYVbr> convert rfc822-to-8bit;
	Mon, 25 Mar 2002 16:31:47 -0500
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
        christophe =?iso-8859-1?q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9CCBEB.D39465A6@zip.com.au>
	<1016914030.949.20.camel@phantasy> <m3r8m851ad.fsf@venus.fo.et.local>
	<1017057192.22083.4.camel@bip>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Mon, 25 Mar 2002 22:31:28 +0100
Message-ID: <m38z8gmj0v.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> writes:

> le lun 25-03-2002 à 12:34, Joachim Breuer a écrit :
>> Being able to redetect a pulled card put in a different slot as a
>> "known" one giving it the same eth<i> (and associated WOL etc. config)
>> as before would of course be nice, but I can't see how this can be
>> cleanly done over reboots.
>
> Some may say that being able to give the same eth<i> to the same bus
> position, even after swapping the card for a new one, is more important
> - think of production machines which can't afford being off-service for
> too long. You just shutdown, swap the cards, poweron and you go. No
> reconfig, that's how it should run.

Reading it again I wasn't all too clear in that last posting - I meant
it to show two alternatives (eth<i> stays with bus vs. eth<i> stays
with card). Each with its own advantages and disadvantages; I don't
have a fixed preference, but a slight leaning towards fixed
bus-position based numbers (spanning different drivers, if at all
possible). That would allow Xavier's scenario even with a different
type of replacement card.

(Yes of course you'd have to reconfig to swap a PCI card for an ISA
one but let's not go there, OK?)


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
