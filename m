Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTH2Slx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbTH2Slx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:41:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:16105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261609AbTH2Slp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:41:45 -0400
Date: Fri, 29 Aug 2003 11:36:34 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_LOG_BUF_SHIFT hardwired in 2.6.0-test4-bk2 ?
Message-Id: <20030829113634.3d5a6f20.rddunlap@osdl.org>
In-Reply-To: <1062181819.3618.4.camel@rousalka.dyndns.org>
References: <1062181819.3618.4.camel@rousalka.dyndns.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Aug 2003 20:30:19 +0200 Nicolas Mailhot <Nicolas.Mailhot@laPoste.net> wrote:

| Hi,
| 
| 	I'm testing acpi changes and unfortunately all the debug messages
| overflow the log buffer. So I decided to increase CONFIG_LOG_BUF_SHIFT 
| in .config (there was a menu entry for this at some time in menuconfig
| but I can't find it anymore).
| 
| 	Anyway no matter what I do the value seems to be reseted to 14 at build
| time. Is there a way to cleanly change it without poking directly into
| the kernel source code ?

You need to enable DEBUG_KERNEL (kernel debugging) to see it in the menu.

After you edit .config, run 'make oldconfig' and that should fix it.

--
~Randy
