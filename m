Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUIPP1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUIPP1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268348AbUIPP1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:27:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:4481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268268AbUIPP0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:26:46 -0400
Date: Thu, 16 Sep 2004 08:21:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>, mk+lkml@arm.linux.org.uk
Cc: mgreer@mvista.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: review MPSC driver
Message-Id: <20040916082135.7cde3b32.rddunlap@osdl.org>
In-Reply-To: <20040916081017.GA2167@fs.tum.de>
References: <20040915150247.37706f7c.rddunlap@osdl.org>
	<20040915214301.53a68379.randy.dunlap@verizon.net>
	<20040916081017.GA2167@fs.tum.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 10:10:17 +0200 Adrian Bunk wrote:

| On Wed, Sep 15, 2004 at 09:43:01PM -0700, Randy.Dunlap wrote:
| > 
| > | http://www.uwsg.iu.edu/hypermail/linux/kernel/0408.3/1549.html
| > 
| > Hi Mark,
| >...
| > 3.  + select SERIAL_CORE
| >     + select SERIAL_CORE_CONSOLE
| > 
| > Please don't use "select".  Use "depends on" instead.
| >...
| 
| That's a silly suggestion since none of these options are user visible.

and Russell King wrote about the same text:
| This is actually (one of the few) correct uses of select.  These two
| symbols are *not* user visible, and are derived from the configuration
| settings of the hardware drivers.

Thanks for your comments.  Any other comments on the driver?

--
~Randy
