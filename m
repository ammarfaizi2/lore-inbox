Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbSKSUWa>; Tue, 19 Nov 2002 15:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266793AbSKSUWa>; Tue, 19 Nov 2002 15:22:30 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:49420 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266777AbSKSUW3>;
	Tue, 19 Nov 2002 15:22:29 -0500
Date: Tue, 19 Nov 2002 21:29:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC/CFT] Separate obj/src dir
Message-ID: <20021119202931.GA15161@mars.ravnborg.org>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20021119201110.GA11192@mars.ravnborg.org> <Pine.LNX.3.95.1021119151730.5943A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021119151730.5943A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 03:22:45PM -0500, Richard B. Johnson wrote:
> I have a question; "What problem is this supposed to solve?"

Two problems (at least):

1) You want to compile your kernel based on two different configurations,
but sharing the same src. No need to have a duplicate of all src.
- There are other ways to do this using symlinks

2) You have the src located on a read-only filesystem.
I have been told this is the case for some SCM systems.

People has requested this feature at several occasions, and here
it is based on the current build system.
It's not ready for inclusion (obviously), and you shall
also see this as a way to check that this is considered usefull
by someone.

	Sam
