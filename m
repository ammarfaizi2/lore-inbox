Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262567AbTCISu2>; Sun, 9 Mar 2003 13:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbTCISu2>; Sun, 9 Mar 2003 13:50:28 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:14611 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262567AbTCISu1>;
	Sun, 9 Mar 2003 13:50:27 -0500
Date: Sun, 9 Mar 2003 20:01:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Romain Lievin <roms@tilp.info>
Subject: Re: [PATCH] kconfig update
Message-ID: <20030309190103.GA1170@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org, Romain Lievin <roms@tilp.info>
References: <Pine.LNX.4.44.0303090432200.32518-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303090432200.32518-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 04:57:54AM +0100, Roman Zippel wrote:
> Hi,
> 
> It took a bit longer than I wanted, but here is finally another kconfig 
> update.

Hi Roman.
Is it on your TODO list to make is more quiet?
Today kconfig dumps out a lot of info when run, making sure no-one even
notices the warnings that occur in the beginning.
When executing
$ make defconfig
$ make V=0
kconfig count for almost half of the output.

It would be really good if the following targets were quiet:
oldconfig, defconfig, all*config.
oldconfig obviously needs to display some info when asking users
for new options.

Also try executing conf with no arguments...

	Sam
