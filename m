Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWBHDVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWBHDVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbWBHDUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:20:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:5249 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030479AbWBHDUC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:20:02 -0500
To: torvalds@osdl.org
Subject: [PATCH 26/29] net/ipv6/mcast.c NULL noise removal
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Message-Id: <E1F6fsA-0006Eh-6G@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:20:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1139015403 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 net/ipv6/mcast.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e80e28b6b67ecc25fa89c9129a5f70de6389b2a6
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 4420948..807c021 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1978,7 +1978,7 @@ static int sf_setstate(struct ifmcaddr6 
 			new_in = psf->sf_count[MCAST_INCLUDE] != 0;
 		if (new_in) {
 			if (!psf->sf_oldin) {
-				struct ip6_sf_list *prev = 0;
+				struct ip6_sf_list *prev = NULL;
 
 				for (dpsf=pmc->mca_tomb; dpsf;
 				     dpsf=dpsf->sf_next) {
-- 
0.99.9.GIT

