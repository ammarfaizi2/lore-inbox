Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136498AbREDUJ6>; Fri, 4 May 2001 16:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136499AbREDUJj>; Fri, 4 May 2001 16:09:39 -0400
Received: from penguins-world.pcsystems.de ([212.63.44.200]:19183 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S136498AbREDUJd>;
	Fri, 4 May 2001 16:09:33 -0400
Message-ID: <3AF30C5F.7445714F@pcsystems.de>
Date: Fri, 04 May 2001 22:09:03 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oystein Viggen <oysteivi@tihlde.org>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: added a new feature: disable pc speaker
In-Reply-To: <8340.988979784@ocs3.ocs-net> <03wv7xm085.fsf@colargol.tihlde.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   setterm -blength 0 (text)
> >   xset b 0 (X11)
>
> Well, some buggy programs don't care about you turning off beeping in
> X.  I think gnome-terminal or such has its own checkbox for turning
> beeps on or off.

Exactly.

> I still agree that this is fixing userspace bugs in the kernel, and
> probably not desirable, even if I think I'd disable the pc speaker if
> the kernel actually asked me.  If nothing else, I figure it would make
> my kernel 0.5k or so smaller  ;)

Something about that, didn't make any comparision to a original
2.4.4 kernel.


I first thought the same Keith did, a userspace program.
This could call the same asm code used in kd_nosound,
but the problem is, the next time _kd_mksound is called,
sound is enabled again.

Can somebody give me a hint where to find documentation about
sysctl and howto use/program that ?
This is what Simon and David suggested.

But as long as I am not able to make sysctl's, I would like
to add this feature under the General setup.

What do you think ?

Nico

