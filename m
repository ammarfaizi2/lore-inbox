Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRIQMl2>; Mon, 17 Sep 2001 08:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273597AbRIQMlS>; Mon, 17 Sep 2001 08:41:18 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:61202 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273588AbRIQMlP>;
	Mon, 17 Sep 2001 08:41:15 -0400
Date: Mon, 17 Sep 2001 09:41:17 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010917122559Z16382-2758+129@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109170936010.2990-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Daniel Phillips wrote:

> Drifting a little further offtopic.  As far as I can tell, there's no
> fundamental reason why we cannot make the current strategy work as
> well as Rik's rmaps probably will, with some more blood, sweat and
> code study.

I don't see any possibility to get that to work without
reverse mapping. Of course, that could be me overlooking
some possibility, but I'm not holding by breath waiting
for somebody to invent this other possibility.

> On the other hand, Matt Dillon, the reigning champion of
> virtual memory managment, was quite firm in stating that we should
> drop the current virtually scanning strategy in favor of 100%
> physical scanning as BSD uses, relying on reverse mapping.
>
>    http://mail.nl.linux.org/linux-mm/2000-05/msg00419.html
>    (Matt Dillon holds forth on the design of BSD's memory manager)

His claims are backed up by FreeBSD's VM performance,
so I'm inclined to believe them. If you think you can
come up with something better, I'll believe you when
you show it...

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

