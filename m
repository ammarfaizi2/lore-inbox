Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbTABEoW>; Wed, 1 Jan 2003 23:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbTABEoW>; Wed, 1 Jan 2003 23:44:22 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:52439 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S265657AbTABEoV>; Wed, 1 Jan 2003 23:44:21 -0500
Date: Wed, 1 Jan 2003 23:52:45 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.54 - OHCI-HCD build fails
Message-ID: <20030102045245.GA1464@Master.Wizards>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 07:43:40PM -0800, Linus Torvalds wrote:
> 
> Happy new year to you all, hopefully most of you are back from the dead 
> and the hangovers are all long gone.  And if not, I'm told reading a large 
> kernel patch is _just_ the medication for whatever ails you.
> 
> The 2.5.54 patch is largely mainly a big collection of various small
> things, all over the place (diffstat shows a long list of small changes,
> with some noticeable activity in UML, the MPT fusion driver and some of
> the fbcon drivers).
> 
> Various module updates (deprecated functions, updated loaders etc), usb, 
> m68k, x86-64 updates, kbuild stuff etc etc.

Build error:

In file included from drivers/usb/host/ohci-hcd.c:137:
drivers/usb/host/ohci-dbg.c: In function `show_list':
drivers/usb/host/ohci-dbg.c:358: `data1' undeclared (first use in this function)
drivers/usb/host/ohci-dbg.c:358: (Each undeclared identifier is reported only once
drivers/usb/host/ohci-dbg.c:358: for each function it appears in.)
drivers/usb/host/ohci-dbg.c:358: `data0' undeclared (first use in this function)
make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1


-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker
  #cooker = moderated Mandrake Cooker

