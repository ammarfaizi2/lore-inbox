Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270653AbTG0CeW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 22:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270654AbTG0CeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 22:34:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:44487 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270653AbTG0CeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 22:34:21 -0400
Date: Sat, 26 Jul 2003 19:46:51 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] sanitize power management config menus
Message-Id: <20030726194651.5e3f00bb.rddunlap@osdl.org>
In-Reply-To: <20030726200213.GD16160@louise.pinerecords.com>
References: <20030726200213.GD16160@louise.pinerecords.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jul 2003 22:02:13 +0200 Tomas Szepe <szepe@pinerecords.com> wrote:

| patch against -bk3.
| 
| -- 

This patch is mostly OK IMHO.

1.  However, both old and new versions say:
  Power management options (ACPI, APM)  --->
but have Software Suspend and CPU Frequency (hidden) below there,
so one has to know to look there for them, while the heading
only says APCI and APM.  I guess that the heading is too restrictive.

2.  APM and ACPI aren't usable together, right?  so should the
Kconfig file prevent both of them from being enabled?

3.  The help text for Software Suspend (not part of this patch)
really needs some help.  Would you address that or shall I?

Thanks,
--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
