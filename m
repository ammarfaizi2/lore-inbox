Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSGVJVW>; Mon, 22 Jul 2002 05:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSGVJVW>; Mon, 22 Jul 2002 05:21:22 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:52488 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315449AbSGVJVW>; Mon, 22 Jul 2002 05:21:22 -0400
Date: Mon, 22 Jul 2002 11:23:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: Andreas Schwab <schwab@suse.de>, Keith Owens <kaos@ocs.com.au>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.25 net/core/Makefile
In-Reply-To: <20020722095528.A2534@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207221120370.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 22 Jul 2002, Russell King wrote:

> What Roman is meaning is something like this:
>
> if [ "$CONFIG_FOO" = "y" ]; then
>    choice ...
> fi

BTW that's not the only problem, a symbol might be defined in
arch/foo/config.in, but not in arch/bar/config.in, so even xconfig doesn't
see everything.

bye, Roman

