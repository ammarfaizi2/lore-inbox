Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTA0QkT>; Mon, 27 Jan 2003 11:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTA0QkT>; Mon, 27 Jan 2003 11:40:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64264 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267222AbTA0QkS>; Mon, 27 Jan 2003 11:40:18 -0500
Date: Mon, 27 Jan 2003 11:46:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: David Woodhouse <dwmw2@infradead.org>, Hal Duston <hald@sound.net>
cc: linux-kernel@vger.kernel.org, Olaf Titz <olaf@bigred.inka.de>
Subject: Re: several messages
In-Reply-To: <Pine.GSO.4.10.10301221816580.22843-100000@sound.net>
Message-ID: <Pine.LNX.3.96.1030127113639.26552A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, David Woodhouse wrote:

> 
> davidsen@tmr.com said:
> >  `uname -r` is the kernel version of the running kernel. It is NOT by
> > magic the kernel version of the kernel you are building... 
> 
> Er, yes. And what's your point? 
> 
> There is _no_ magic that will find the kernel you want to build against
> today without any input from you. Using the build tree for the
> currently-running kernel, if installed in the standard place, is as good a
> default as any. Of course you should be permitted to override that default.

You make my point for me, there is no magic, and when building a module it
should require that the directory be specified by either a command line
option (as noted below) or by being built as part of a source tree. There
*is* no good default in that particular case.


On Wed, 22 Jan 2003, Hal Duston wrote:

> I use "INSTALL_MOD_PATH=put/the/modules/here/instead/of/lib/modules" in my
> .profile or whatever in order to drop the modules into another directory
> at "make modules_install" time.  Is this one of the things folks are
> talking about?

Related for sure, the point I was making was that there is no good default
place to put modules built outside a kernel source tree (and probably also
when built for multiple kernels). I was suggesting that the module tree of
the running kernel might be a really poor choice. I don't think I was
clear in my first post, I was not suggesting a better default, I was
suggesting that any default is likely to bite.

I'm not unhappy that Mr. Woodhouse disagrees, I just think he missed my
point the first time and I'm trying to clarify.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

