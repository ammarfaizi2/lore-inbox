Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbTJ2VFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 16:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTJ2VFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 16:05:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:31134 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261585AbTJ2VFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 16:05:47 -0500
Date: Wed, 29 Oct 2003 13:03:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Han Boetes <han@mijncomputer.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] menuconfig alternate theme
Message-Id: <20031029130307.044e9804.rddunlap@osdl.org>
In-Reply-To: <20031028004520.GG13373@boetes.org>
References: <20031028004520.GG13373@boetes.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 01:44:58 +0059 Han Boetes <han@mijncomputer.nl> wrote:

| Hi,
| 
| To react on this thread somewhat:
| 
|   http://marc.theaimsgroup.com/?l=linux-kernel&m=104202311306008&w=2
| 
| I made an alternative theme for menuconfig with a black background and
| white/yellow/red/grey text which I find more readable. Of course it's
| way to late to be included and I don't expect that at all. Just
| something I wanted to share with the one or two people that share my
| problem with reading the current settings.

Yes, the blue/cyan/gray colors can be a problem on some displays.

Jan-Benedict Glaw modified menuconfig to support monochrome mode,
so I have merged your patch and his, but instead of replacing the
default menuconfig colors, I added an alternate color theme and
monochrome support to the default color theme.

This patch is available at:
http://developer.osdl.org/rddunlap/menuconfig/menuconfig_alt_mono.patch

Usage is:
make menuconfig MENUCONFIG_COLOR=monochrome|mono|alternate|alt

--
~Randy
