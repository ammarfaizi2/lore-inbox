Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318174AbSHDT6m>; Sun, 4 Aug 2002 15:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSHDT6m>; Sun, 4 Aug 2002 15:58:42 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:34826 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318174AbSHDT6m>;
	Sun, 4 Aug 2002 15:58:42 -0400
Date: Sun, 4 Aug 2002 22:10:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       martin@dalecki.de
Subject: Re: [PATCH] automatic module_init ordering
Message-ID: <20020804221028.A8973@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	martin@dalecki.de
References: <20020802232232.A25583@mars.ravnborg.org> <Pine.LNX.4.44.0208022011490.24984-100000@chaos.physics.uiowa.edu> <20020804001147.A9226@mars.ravnborg.org> <3D4D48A7.6BA919D2@linux-m68k.org> <20020804220417.A8175@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020804220417.A8175@mars.ravnborg.org>; from sam@ravnborg.org on Sun, Aug 04, 2002 at 10:04:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 10:04:17PM +0200, Sam Ravnborg wrote:
> Looks good, a few comments remains. We are down to matter of personal taste.
One more, let this be the last one...
Doing:
$> make KBUILD_VERBOSE=0
..... Compilation succeeds
$> make KBUILD_VERBOSE=0
make[1]: `generated-initcalls.o' is up to date.
make[2]: `vmlinux' is up to date.

Could we please get rid of the superflous 'generated-initcalls.o' is up ....

	Sam
