Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSGLSsR>; Fri, 12 Jul 2002 14:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316774AbSGLSsQ>; Fri, 12 Jul 2002 14:48:16 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:5771 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316693AbSGLSsP>; Fri, 12 Jul 2002 14:48:15 -0400
Date: Fri, 12 Jul 2002 11:50:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin MOKREJ? <mmokrejs@natur.cuni.cz>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Missing files in 2.4.19-rc1
Message-ID: <20020712185023.GL695@opus.bloom.county>
References: <Pine.LNX.4.44.0207120643190.3421-100000@hawkeye.luckynet.adm> <Pine.OSF.4.44.0207122035310.281934-100000@tao.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.44.0207122035310.281934-100000@tao.natur.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 08:39:18PM +0200, Martin MOKREJ? wrote:

> `make dep` gave again:
[snip]
> au1000_gpio.c:41: asm/au1000.h: No such file or directory
> au1000_gpio.c:42: asm/au1000_gpio.h: No such file or directory

These aren't an issue, since you're not compiling for MIPS, and that's
for the MIPS-specific au1000 GPIO driver.  And those files aren't
missing on MIPS.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
