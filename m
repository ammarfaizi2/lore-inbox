Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264878AbUD2PpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264878AbUD2PpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 11:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUD2PpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 11:45:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:52198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264878AbUD2PpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 11:45:14 -0400
Date: Thu, 29 Apr 2004 08:38:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com,
       mpm@selenic.com, zwane@linuxpower.ca
Subject: Re: [PATCH] Kconfig.debug family
Message-Id: <20040429083820.6457fa84.rddunlap@osdl.org>
In-Reply-To: <20040426164252.GA19246@smtp.west.cox.net>
References: <20040421205140.445ae864.rddunlap@osdl.org>
	<20040426164252.GA19246@smtp.west.cox.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004 09:42:52 -0700 Tom Rini wrote:

| On Wed, Apr 21, 2004 at 08:51:40PM -0700, Randy.Dunlap wrote:
| 
| > Localizes kernel debug options in lib/Kconfig.debug.
| > Puts arch-specific debug options in $ARCH/Kconfig.debug.
| [snip]
| >  arch/ppc/Kconfig             |  124 -------------------------
| >  arch/ppc/Kconfig.debug       |   71 ++++++++++++++
| 
| OCP shouldn't be moved into Kconfig.debug, it's just in an odd location
| right now.


Thanks.  I moved it to under Processor options, before Platform
options.  Is that OK?

Updated patch is here:
  http://developer.osdl.org/rddunlap/patches/kdebug1file_266rc2_v2.patch
(applies to 2.6.6-rc3 with a few offsets)

Waiting for 2.6.6-final...

--
~Randy
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature) -- akpm
