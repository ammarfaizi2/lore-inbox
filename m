Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUG1Qd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUG1Qd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUG1Qax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:30:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:24759 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267313AbUG1Q2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:28:44 -0400
Date: Wed, 28 Jul 2004 09:08:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Kconfig.debug: combine Kconfig debug options
Message-Id: <20040728090839.606414c1.rddunlap@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0407272328500.19529@waterleaf.sonytel.be>
References: <20040723231158.068d4685.rddunlap@osdl.org>
	<Pine.GSO.4.58.0407271451130.19529@waterleaf.sonytel.be>
	<20040727104737.0de2da5b.rddunlap@osdl.org>
	<Pine.GSO.4.58.0407272328500.19529@waterleaf.sonytel.be>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 23:29:43 +0200 (MEST) Geert Uytterhoeven wrote:

| > DEBUG_SLAB is not available in cris, h8300, m68knommu, sh, sh64,
| > or v850 AFAICT.  Yes/no ?
| 
| Probably someone just forgot to add them. DEBUG_SLAB is used in
| arch-independent code only. So I guess it doesn't harm to allow DEBUG_SLAB for
| all archs.


Patch updated for this and for 2.6.8-rc2-bk7.

  http://developer.osdl.org/rddunlap/kconfig/kconfig-debug-268rc2bk7.patch

and sending directly to Andrew.

--
~Randy
