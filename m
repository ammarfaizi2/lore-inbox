Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSDJQ7M>; Wed, 10 Apr 2002 12:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSDJQ7L>; Wed, 10 Apr 2002 12:59:11 -0400
Received: from linuxhacker.ru ([212.16.0.238]:54022 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S312582AbSDJQ7K>;
	Wed, 10 Apr 2002 12:59:10 -0400
Date: Thu, 11 Apr 2002 00:55:04 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: Brent Cook <busterb@mail.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse interrupts: the death knell of a VP6
Message-ID: <20020411005504.A17409@linuxhacker.ru>
In-Reply-To: <20020410192339.A22777@namesys.com> <20020410112810.L60900-100000@ozma.union.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Apr 10, 2002 at 11:43:13AM -0500, Brent Cook wrote:

> > > I have already tried removing memory, adding memory, changing processors,
> > > video cards. The only thing that has remained constant is the VP6
> > > motherboard and the hard drive.
> > My VP6 died on me recently with some funny symptoms:
> > it hangs in X when I start netscape and move mouse, or if I do
> > bk clone on kernel tree, it dies with
> > kernel BUG at /usr/src/linux-2.4.18/include/asm/smplock.h:62!
> Very interesting. I could do the same thing, and have a similar lock with
> a PS/2 mouse. I will start looking in smplock.h if the MPS change does not
> help.

No need to look there.
If you see sch a BUG message in your logs, you seems to have bad hardware.

> > BUG in various places pretty soon.
> > (this BUG is only appears if 2 CPUs are present in motherboard).
> > So if your troubles began only recently, you might want to try another
> > motherboard just to be sure.
> I received the motherboard used, so I do not know if this is a recent
> development. I have tried several other kernels which all show the same
> locking behavior with PS/2 mice (2.4.17, 2.4.18, 2.5.7-dj3.) The previous
> owner ran Windows XP (developer preview) on the board, and it had a
> tendency to lock often, especially under high IO. I attributed this to
> software issues, though now I wonder why the previous owner _really_ gave
> it to me!

Yeah, Windows crashed on me too (win2k, though) when I tried.
Luckily I bought my as a new one 11 months ago and I still have 1 month of
warranty, and the good thing is my board will be replaced tomorrow ;)

> I have used a Tyan Tiger 100 with two processors and an Intel BX chipset,
> with great success and no similar locks, so I am 50% certain that a
> hardware difference is the root cause of the problem. Hopefully, someone
> else will have seen similar problems.

Who knows. May be people in question silently replaced damaged harware with
good one and forgot about it already ;)
Or may be they ustill use windows and blame Microsoft on all the crashes ;)

Bye,
    Oleg
