Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTABVu4>; Thu, 2 Jan 2003 16:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267309AbTABVuq>; Thu, 2 Jan 2003 16:50:46 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46855 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267306AbTABVug>; Thu, 2 Jan 2003 16:50:36 -0500
Date: Thu, 2 Jan 2003 16:56:50 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] do justice to netfilter configuration
In-Reply-To: <20030101174458.GK15200@louise.pinerecords.com>
Message-ID: <Pine.LNX.3.96.1030102164458.20297F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Tomas Szepe wrote:

> $subj.  I wanted to do this for a long time, so here comes:
> 
> o  Move all IPv4 netfilter config entries to net/ipv4/netfilter/Kconfig.
> o  Move the netfilter submenu right under the netfilter on/off switch.
> o  Move the netfilter debug option into the netfilter submenu.
> o  Move all netfilter settings as close to their IPv6 sibling as possible.
> o  Rename "IP: Netfilter Configuration" to "IPv4 Netfilter Configuration"
> o  Rename "IPv6: Netfilter Configuration" to "IPv6 Netfilter Configuration"

Another Christmas present. I'd just like to thank you for the work you
have done on making the options make sense.

I haven't tried the mods to PCMCIA yet, but I certainly would like to stop
chasing through other menus to turn on the drivers I need. Repeat thought
for USB.

Now if there was a way to symbolic link to required options, so instead of
being told you can't config USB this-n-that because you didn't find human
interface whatever, you could click into the menu to turn on the whatever
and pop back to what you really wanted to do. Yes, this is definitely 2.7
material (if at all) because someone will create either a loop or
recursion, but I can dream, right?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

