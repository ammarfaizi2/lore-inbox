Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSKHVIJ>; Fri, 8 Nov 2002 16:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSKHVIJ>; Fri, 8 Nov 2002 16:08:09 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:21777 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262394AbSKHVII>; Fri, 8 Nov 2002 16:08:08 -0500
Date: Fri, 8 Nov 2002 22:14:36 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: kconfig: Generate prerequisites
In-Reply-To: <20021108183644.GA2992@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0211082148030.2113-100000@serv>
References: <20021108183644.GA2992@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Nov 2002, Sam Ravnborg wrote:

> Example:
> conf -p arch/i386/Kconfig
> arch/i386/Kconfig \
> net/Kconfig \
> drivers/Kconfig
> 
> The check could be made in kconfig as well which should speed up
> things. No need for make to stat the same file as Kconfig already
> have stat'ed. From a speed persepctive I like this version best.

Did you check ..config.cmd (or .config.cmd in 2.5.47)? :)

bye, Roman

