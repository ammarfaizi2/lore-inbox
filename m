Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261674AbTCLAD5>; Tue, 11 Mar 2003 19:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbTCLAD5>; Tue, 11 Mar 2003 19:03:57 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:13208 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261674AbTCLADx>; Tue, 11 Mar 2003 19:03:53 -0500
Subject: Re: [patch] oprofile for ppc
From: Albert Cahalan <albert@users.sf.net>
To: mikpe@csd.uu.se
Cc: Andrew Fleming <afleming@motorola.com>,
       Segher Boessenkool <segher@koffie.nl>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       o.oppitz@web.de, linux-kernel@vger.kernel.org
In-Reply-To: <15982.29106.674299.704117@gargle.gargle.HOWL>
References: <3E6D469C.8060209@koffie.nl>
	<FEB94991-540B-11D7-BAD1-000393C30512@motorola.com> 
	<15982.29106.674299.704117@gargle.gargle.HOWL>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Mar 2003 19:10:53 -0500
Message-Id: <1047427855.5973.80.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 18:30, mikpe@csd.uu.se wrote:
>>>>> Benjamin Herrenschmidt wrote:

>>>>>> Beware though that some G4s have a nasty bug that
>>>>>> prevents using the performance counter interrupt
>>>>>> (and the thermal interrupt as well).
...
> Is this bug restricted to 7400/7410 only, or does it
> affect the 750 (and relatives) and 604/604e too?
>
> I'm thinking about ppc support for my perfctr driver,
> and whether overflow interrupts are worth supporting
> or not given the errata.

604/604e doesn't even have performance monitoring AFAIK.
I've heard nothing to suggest that the 750 is affected.

I'll give you a hand; point me to the latest perfctr code
and explain how it is supposed to interact with oprofile.


