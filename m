Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318774AbSHER47>; Mon, 5 Aug 2002 13:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318802AbSHER47>; Mon, 5 Aug 2002 13:56:59 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:56710
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S318774AbSHER46>; Mon, 5 Aug 2002 13:56:58 -0400
Date: Mon, 5 Aug 2002 11:00:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Harald Dunkel <harri@synopsys.COM>
Cc: Thunder from the hill <thunder@ngforever.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19
Message-ID: <20020805180014.GB11424@opus.bloom.county>
References: <Pine.LNX.4.44.0208030631580.5119-100000@hawkeye.luckynet.adm> <3D4BCF5A.7080904@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4BCF5A.7080904@Synopsys.COM>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2002 at 02:40:58PM +0200, Harald Dunkel wrote:
> Hi T.
> 
> Thunder from the hill wrote:
> >Hi,
> >
> >On Sat, 3 Aug 2002, Harald Dunkel wrote:
> >
> >>PS: After booting 2.4.19 'depmod -a' works as expected, but
> >>    'depmod -ae -F /boot/System.map-2.4.19 2.4.19' doesn't. I
> >>    would guess its a problem with depmod.
> >
> >
> >I'd rather guess the problem is that you didn't make dep after config 
> >changes. Read the FAQ, please.
> 
> Of course 'make dep' was in. But Debian includes modutils 2.4.15. After
> upgrading to 2.4.19 the problem is gone. Debian is out of date :-(.
> 
> Maybe it would help to update Documentation/Changes to list the new
> modutils, too?

Are you sure you didn't just get bit by a binutils bug?  Newer modutils
are required by newer binutils, but older binutils certainly work.  Is
this Debian/unstable or Debian/stable?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
