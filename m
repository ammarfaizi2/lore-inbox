Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTF2Uxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbTF2Uxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:53:53 -0400
Received: from p508B5A53.dip.t-dialin.net ([80.139.90.83]:58771 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP id S263600AbTF2UwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:52:05 -0400
Date: Sun, 29 Jun 2003 23:04:12 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [patch] 2.5.73-mm2: let CONFIG_TC35815 depend on CONFIG_TOSHIBA_JMR3927
Message-ID: <20030629210412.GC12516@linux-mips.org>
References: <20030627202130.066c183b.akpm@digeo.com> <20030629190431.GB282@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030629190431.GB282@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 09:04:32PM +0200, Adrian Bunk wrote:

> The following problem seems to come from Linus' tree:
> 
> I got an error at the final linking with CONFIG_TC35815 enabled since
> the variables tc_readl and tc_writel are not available.
> 
> The only place where they are defined is arch/mips/pci/ops-jmr3927.c, so 
> I assume the following was intended:

Not really intended but it makes sense as this particular boards seems
to be the only user of that chip - which already has vanished from
Toshiba's pages anyway ...

  Ralf
