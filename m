Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267256AbUHIUbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267256AbUHIUbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267211AbUHIUaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:30:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:59364 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267219AbUHIU1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:27:43 -0400
Date: Mon, 9 Aug 2004 13:05:54 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org, zippel@linux-m68k.org
Subject: Re: [PATCH] save kernel version in .config file
Message-Id: <20040809130554.0405f7e5.rddunlap@osdl.org>
In-Reply-To: <4117D88E.6080801@tmr.com>
References: <20040803225753.15220897.rddunlap@osdl.org>
	<4117D88E.6080801@tmr.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2004 16:03:26 -0400 Bill Davidsen wrote:

| Randy.Dunlap wrote:
| > (from June/2004 email thread:
| > http://marc.theaimsgroup.com/?t=108753573200001&r=1&w=2
| > )
| > 
| > Several people found this useful, none opposed (afaik).
| > 
| > Saves kernel version in .config file, e.g.:
| > 
| > #
| > # Automatically generated make config: don't edit
| > # Linux kernel version: 2.6.8-rc3
| > # Tue Aug  3 22:55:57 2004
| > #
| > 
| > Please merge.
| > ---
| > 
| > Save kernel version info and date when writing .config file.
| > Tested with 'make {menuconfig|xconfig|gconfig}'.
| 
| I don't see "oldconfig" here, I'm sure there are people who don't care 
| because they want to roll every kernel fresh, but for the rest of us...

OK, I'll change the description (above):

Tested with 'make {menuconfig|xconfig|gconfig|oldconfig}'.

In fact, what I posted in the email ('#' above) was from oldconfig.

--
~Randy
