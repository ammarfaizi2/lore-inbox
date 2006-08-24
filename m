Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWHXGhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWHXGhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWHXGgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:36:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:23730 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030337AbWHXGgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:36:38 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 16:36:39 +1000
Message-Id: <1060824063639.4925@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 11] knfsd: Fix a botched comment from the last patchset
References: <20060824162917.3600.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-08-24 16:23:37.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-08-24 16:23:37.000000000 +1000
@@ -49,7 +49,7 @@
  *	svc_pool->sp_lock protects most of the fields of that pool.
  * 	svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpcnt.
  *	when both need to be taken (rare), svc_serv->sv_lock is first.
- *	BKL protects svc_serv->sv_nrthread, svc_pool->sp_nrthread
+ *	BKL protects svc_serv->sv_nrthread.
  *	svc_sock->sk_defer_lock protects the svc_sock->sk_deferred list
  *	svc_sock->sk_flags.SK_BUSY prevents a svc_sock being enqueued multiply.
  *
