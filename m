Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273544AbRIUOWb>; Fri, 21 Sep 2001 10:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273552AbRIUOWV>; Fri, 21 Sep 2001 10:22:21 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39686 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S273544AbRIUOWM>; Fri, 21 Sep 2001 10:22:12 -0400
Date: Fri, 21 Sep 2001 10:17:29 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Lockup with 2.4.9-ac10 on Athlon 
In-Reply-To: <10119.1001072532@redhat.com>
Message-ID: <Pine.LNX.3.96.1010921101144.28645B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, David Woodhouse wrote:

> 
> davidsen@tmr.com said:
> >  Look for BIOS updates. I have a BP6 (dual Celeron) system, and I am
> > really disappointed that the only way I can power it down under
> > software control is to boot to another o/s. You may be able to get a
> > BIOS which works.
> 
> Strange - mine works. Either with APM and 'apm=power-off' on the command 
> line, or with ACPI and a hack to work around the incompetence of Abit's 
> BIOS engineers.

Is this something Linux could recognize and patch, like the Athlon problem
with the VIA chipset? Linux works around many bugs, this would be just
another in the init portion, which is released when complete and has no
runtime penalty.

However, I thought this was something disabled in SMP mode, since it used
to work with a uni build. I'll have to look again, I would really like to
have a clean power-down after running long term stuff to completion.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

