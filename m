Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTI2OqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 10:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTI2OqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 10:46:15 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:52422 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S263472AbTI2OqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 10:46:12 -0400
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
From: David Woodhouse <dwmw2@infradead.org>
To: Valdis.Kletnieks@vt.edu
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Adrian Bunk <bunk@fs.tum.de>, netdev@oss.sgi.com, davem@redhat.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200309291438.h8TEcVtH021550@turing-police.cc.vt.edu>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030928233909.GG1039@conectiva.com.br> <20030929001439.GY15338@fs.tum.de>
	 <20030929003229.GM1039@conectiva.com.br>
	 <1064826174.29569.13.camel@hades.cambridge.redhat.com>
	 <20030929141548.GS1039@conectiva.com.br>
	 <200309291438.h8TEcVtH021550@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1064846768.21551.15.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Mon, 29 Sep 2003 15:46:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-29 at 10:38 -0400, Valdis.Kletnieks@vt.edu wrote:
> No, this is the behavior we want, and we can write Kconfig help entries that
> explain it.
> 
> Anybody want to do a sanity check against CONFIG_IP6_NF_IPTABLES - that
> looks like another gotcha if it isn't implemented properly (it may be, I just haven't
> actually looked it over)?

In 2.7 we really should just stop the CONFIG_xxx_MODULE definitions
being available during builds of the static kernel.

-- 
dwmw2

