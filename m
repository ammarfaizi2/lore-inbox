Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTLSRHJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 12:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTLSRHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 12:07:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:38883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263486AbTLSRHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 12:07:06 -0500
Date: Fri, 19 Dec 2003 09:05:41 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: khc@pm.waw.pl, linux-kernel@vger.kernel.org
Subject: Re: [patch] ide.c as a module
Message-Id: <20031219090541.10fae126.rddunlap@osdl.org>
In-Reply-To: <200312191726.46147.bzolnier@elka.pw.edu.pl>
References: <20031211202536.GA10529@starbattle.com>
	<200312121837.31121.bzolnier@elka.pw.edu.pl>
	<m3u13zynm8.fsf@defiant.pm.waw.pl>
	<200312191726.46147.bzolnier@elka.pw.edu.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003 17:26:46 +0100 Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

| On Thursday 18 of December 2003 01:29, Krzysztof Halasa wrote:
| > BTW: modular IDE in 2.4.23 is still problematic - you can't unload the
| > chipset driver (piix.o or something like) which in turn references the
| > core IDE module.
| 
| It is probably too much work to fix it (properly) in 2.4.x and 2.6.x...
| 
| Please note that there is no refcounting in IDE drivers,
| there is no host object type, also table of IDE ports (ide_hwifs[]) is static.
| 
| I hope 2.7 will obsolete drivers/ide...

in favor of libata or what?

--
~Randy
MOTD:  Always include version info.
