Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284985AbRLVEND>; Fri, 21 Dec 2001 23:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286662AbRLVEMy>; Fri, 21 Dec 2001 23:12:54 -0500
Received: from otter.mbay.net ([206.40.79.2]:63505 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S284985AbRLVEMo> convert rfc822-to-8bit;
	Fri, 21 Dec 2001 23:12:44 -0500
From: John Alvord <jalvo@mbay.net>
To: "David Gomez" <davidge@viadomus.com>
Cc: Dan Kegel <dkegel@ixiacom.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17
Date: Fri, 21 Dec 2001 20:12:39 -0800
Message-ID: <sr182u8fptii0ptu44s0uvrhafn44hoi8a@4ax.com>
In-Reply-To: <3C23988D.47A96760@ixiacom.com> <Pine.LNX.4.33.0112212203460.1184-100000@fargo>
In-Reply-To: <Pine.LNX.4.33.0112212203460.1184-100000@fargo>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001 22:09:09 +0100 (CET), "David Gomez"
<davidge@viadomus.com> wrote:

>
>> > final:
>> >
>> > - Fix more loopback deadlocks                   (Andrea Arcangeli)
>> > - Make Alpha with Nautilus chipset and
>> >   Irongate chipset configuration compile
>> >   correctly                                     (Michal Jaegermann)
>> >
>> > rc2:
>> >
>> > - Fix potential oops with via-rhine             (Andrew Morton)
>> > - sysvfs: mark inodes as bad in case of read
>> > ...
>>
>> Um, what happened to the idea of 'no changes between the last
>> release candidate and final'?
>
>I think the policy is 'not to add unnecessary changes' , not 'no changes'.
>
>> I'm disappointed; I thought we were entering a new era of
>> release discipline in the stable kernel.
>
>I'd be dissapointed if Marcelo had released and stable kernel still
>with the loopback deadlocks. And i don't think the alpha compile fix is
>going to break anything.

One possibility would be to release 2.4.17 and 2.4.18-pre1
simultaneously, with the otherwise last minute changes. There have
been so many brown-bag bugs introduced by the last changes, there
everyone is or should be nervous. Immediately launching the next -pre
series will help keep the momentum moving while preserving the more
certain knowledge of the quality of the last -rc level.

john alvord
