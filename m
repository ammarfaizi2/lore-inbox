Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbTLaKT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbTLaKT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:19:27 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:60063 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264233AbTLaKTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:19:22 -0500
Date: Wed, 31 Dec 2003 11:19:07 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-rc1-mm1
Message-ID: <20031231101907.GB16860@louise.pinerecords.com>
References: <20031231004725.535a89e4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231004725.535a89e4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-31 2003, Wed, 00:47 -0800
Andrew Morton <akpm@osdl.org> wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1-rc1/2.6.1-rc1-mm1/
> A few small additions, but mainly a resync with mainline.

In file included from include/linux/netfilter_bridge/ebtables.h:16,
                 from net/bridge/netfilter/ebtables.c:25:
include/linux/netfilter_bridge.h: In function `nf_bridge_maybe_copy_header':
include/linux/netfilter_bridge.h:74: error: `ETH_P_8021Q' undeclared (first use in this function)
include/linux/netfilter_bridge.h:74: error: (Each undeclared identifier is reported only once
include/linux/netfilter_bridge.h:74: error: for each function it appears in.)
include/linux/netfilter_bridge.h: In function `nf_bridge_save_header':
include/linux/netfilter_bridge.h:87: error: `ETH_P_8021Q' undeclared (first use in this function)
make[3]: *** [net/bridge/netfilter/ebtables.o] Error 1
make[2]: *** [net/bridge/netfilter] Error 2
make[1]: *** [net/bridge] Error 2
make: *** [net] Error 2

-- 
Tomas Szepe <szepe@pinerecords.com>
