Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSGXTCG>; Wed, 24 Jul 2002 15:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317539AbSGXTCF>; Wed, 24 Jul 2002 15:02:05 -0400
Received: from employees.nextframe.net ([212.169.100.200]:10490 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S317541AbSGXTCE>; Wed, 24 Jul 2002 15:02:04 -0400
Date: Wed, 24 Jul 2002 21:16:25 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Chris Snyder <csnyder@mvpsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  Problems with Mylex DAC960P RAID controller
Message-ID: <20020724211625.B2356@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <3D3ED215.3080900@mvpsoft.com> <20020724205019.A2356@sexything> <3D3EF5BD.5070901@mvpsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3EF5BD.5070901@mvpsoft.com>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 02:45:17PM -0400, Chris Snyder wrote:
> Morten Helgesen wrote:
> 
> >DAC960P ? I`ve got a box running 2.4.18 with a Mylex DAC960PTL1 card. The
> >box is rock solid. If my memory isn`t hosed, the correct name 
> >of the card is 'Mylex AccelRaid 250'.
> 
> The card BIOS says it's a DAC960P - that's all the info I've got.

Aah ...

> 
> >The DAC960 driver is quite verbose - this is what I`ve got :
> >
> >kernel: DAC960: ***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 
> >*****
> >kernel: DAC960: Copyright 1998-2001 by Leonard N. Zubkoff 
> ><lnz@dandelion.com>
> 
> That's all the info it prints, then it hangs.  It seems to be that 
> something's happening when it tries to detect the controller.

Yep - I see ... you haven`t got another linux box around (with a distro actually
installed :), do you ? I guess
it would be easier to debug this if you could move the controller to another
box and actually fiddle with the driver source ... debug printks can actually be
useful :)

I noticed that the return value from request_region() is not checked ...

> 
> >Never had problems with the DAC960 driver in 2.4 (or 2.2 for that matter) 
> >...
> >Could you provide the message printed by your kernel ? We can continue from
> >there ... maybe Leonard has an idea of what`s going on ... Leonard ?
> 
> There really aren't any messages printed by the kernel, other than the 
> DAC960 version and copyright info, since it completely hangs.  I'm 
> booting from a distro (Gentoo) installation CD, so no syslog facility is 

As I said - it would be useful if you could actually put the controller
in a box _with_ a distro already installed :)

> in place.
> 

Cheers

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
