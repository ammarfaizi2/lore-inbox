Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318519AbSHPQTb>; Fri, 16 Aug 2002 12:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318536AbSHPQTb>; Fri, 16 Aug 2002 12:19:31 -0400
Received: from ppp71-3-70.miem.edu.ru ([194.226.32.70]:11904 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S318519AbSHPQTa>;
	Fri, 16 Aug 2002 12:19:30 -0400
Message-ID: <3D5D261E.7070103@yahoo.com>
Date: Fri, 16 Aug 2002 20:19:42 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Albert D. Cahalan wrote:
>> as it's opened it starts generating some horrible clicks and a
>> high-pitched whine.
>> Do I blame my motherboard (actually, a laptop)? Is there any way to 
>> fix this, or at least improve it?
> Adding a capacitor is supposed to help a PC speaker
> sound driver.
Ah, of course, that's what Denis Vlasenko was talking
about, now I see.
Clicks are caused by disabled ints, but whine is another
problem.
Recalling my old 386 board where I tried similar driver
under DOS and it also produced high pitched tone so I
ended up adding a capacitor, which solved the problem.
Now I think that the better solution is to add an option
to use higher modulation rates.
I have added an option to use 36KHz instead of 18.5KHz.
I beleive that this is far above the frequency range of
any motherboard and can solve the problem.

Andrew Rodland, could you please test the new patch from
my page and see if enabling the high freq modulation fixes
your problem, at least whine, not clicks?

