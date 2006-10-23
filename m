Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWJWDp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWJWDp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWJWDp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:45:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:6722 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751408AbWJWDp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:45:27 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,341,1157353200"; 
   d="scan'208"; a="149041406:sNHT17501036"
Subject: Re: 2.6.19-rc2: ieee80211/ipw2200 regression
From: Zhu Yi <yi.zhu@intel.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, jketreno@linux.intel.com
In-Reply-To: <200610230244.43948.s0348365@sms.ed.ac.uk>
References: <200610230244.43948.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Organization: Intel Corp.
Date: Mon, 23 Oct 2006 11:42:52 +0800
Message-Id: <1161574972.19188.42.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 02:44 +0100, Alistair John Strachan wrote:
> [alistair] 02:42 [~/linux-git] cat /boot/System.map-`uname -r` | grep
> arc4
> c01f7970 t arc4_crypt
> c01f7a10 t arc4_set_key
> c0341be0 d arc4_alg
> c0390cc0 t arc4_init
> c03a393c t __initcall_arc4_init
> c03a6380 t arc4_exit 

It should be OK if you configured ARC4 and CRC32 in kernel. Can you also
see the symbols in /proc/kallsyms? (In case /boot/System.map-`uname -r`
differs with the currently running kernel.)

Thanks,
-yi
