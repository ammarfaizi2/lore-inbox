Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSKCRub>; Sun, 3 Nov 2002 12:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbSKCRub>; Sun, 3 Nov 2002 12:50:31 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:28170 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262266AbSKCRub>; Sun, 3 Nov 2002 12:50:31 -0500
Date: Sun, 3 Nov 2002 18:56:53 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Petr Baudis <pasky@ucw.cz>
cc: linux-kernel@vger.kernel.org, <mec@shout.net>
Subject: Re: [kconfig] Survival of scripts/Menuconfig?
In-Reply-To: <20021103111333.GA2516@pasky.ji.cz>
Message-ID: <Pine.LNX.4.44.0211031803380.6949-100000@serv>
References: <20021103111333.GA2516@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002, Petr Baudis wrote:

>   I'd like to ask if there's still a reason to keep scripts/Menuconfig in the
> tree; AFAIK it's not used at all anymore, can we thus remove it? (Possibly we
> could mention its existence and basic credits at the top of
> scripts/kconfig/mconf.c, which is at least partially based on it?) If the
> answer is yes, I'm willing to do the patch etc.

There is more to be removed, which I plan to do with the next update.

>   I'm asking because I want to move the relevant lxdialog functionality to
> scripts/kconfig/mconf.c (I think it makes no sense to call lxdialog externally
> from mconf.c) and get rid of the separate lxdialog tree. And scripts/Menuconfig
> is the only other user of lxdialog.

What do you plan to do with it exactly?
In any case could you start with a copy of mconf.c? We are past feature 
freeze now, so it makes little sense to remove lxdialog, but it could be 
distributed separately together with the qt/gtk version.

bye, Roman

