Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUD2VDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUD2VDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264867AbUD2VDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:03:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:474 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264858AbUD2U7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:59:55 -0400
Date: Thu, 29 Apr 2004 13:52:41 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: trini@kernel.crashing.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, mpm@selenic.com, zwane@linuxpower.ca
Subject: Re: [PATCH] Kconfig.debug family (v3-bart)
Message-Id: <20040429135241.4e46fd46.rddunlap@osdl.org>
In-Reply-To: <200404292054.49663.bzolnier@elka.pw.edu.pl>
References: <20040421205140.445ae864.rddunlap@osdl.org>
	<200404291842.23968.bzolnier@elka.pw.edu.pl>
	<20040429095143.6de85098.rddunlap@osdl.org>
	<200404292054.49663.bzolnier@elka.pw.edu.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004 20:54:49 +0200 Bartlomiej Zolnierkiewicz wrote:

| On Thursday 29 of April 2004 18:51, Randy.Dunlap wrote:
| > On Thu, 29 Apr 2004 18:42:23 +0200 Bartlomiej Zolnierkiewicz wrote:
| 
| > | Only on x86 it does a proper thing:
| > |
| > | arch/<arch>/Kconfig -> arch/<arch>/Kconfig.debug -> lib/Kconfig.debug
| >
| > That's because I goofed up... it's the wrong patch.
| >
| > I was trying something that someone suggested (You!) and it didn't
| 
| :)
| 
| > work out in a desirable way as far as how it's presented in
| > {x,menu}config, so I need to fix that (i386 part) and then you
| 
| In your previous patch (vs 2.6.5) there was only one "Kernel hacking" menu,
| in this one there are two menus: "Kernel hacking" and "X86 kernel hacking".
| 
| I hacked it quickly and I have one menu again (on x86 arch specific options
| are not configurable) so I also hacked+checked  ppc and 'make menuconfig'
| looks OK).  Did I miss something?

Bart's changes still look good.  I've updated the entire patch
to use that model.  It's available here:
  http://developer.osdl.org/rddunlap/patches/kdebug1menu_266rc2_v3.patch


Any more comments before 2.6.6?

Thanks,
--
~Randy
