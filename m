Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVCTMBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVCTMBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 07:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVCTMAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 07:00:24 -0500
Received: from coderock.org ([193.77.147.115]:4492 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262151AbVCTMAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 07:00:04 -0500
Date: Sun, 20 Mar 2005 12:59:59 +0100
From: Domen Puncer <domen@coderock.org>
To: sds@epoch.ncsc.mil
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 3/4 with proper signed-off] security/selinux/ss/avtab.c: fix sparse warnings
Message-ID: <20050320115959.GV14273@nd47.coderock.org>
References: <20050319131945.3A8CE1ECA8@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131945.3A8CE1ECA8@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/security/selinux/ss/avtab.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN security/selinux/ss/avtab.c~sparse-security_selinux_ss_avtab security/selinux/ss/avtab.c
--- kj/security/selinux/ss/avtab.c~sparse-security_selinux_ss_avtab	2005-03-20 12:11:32.000000000 +0100
+++ kj-domen/security/selinux/ss/avtab.c	2005-03-20 12:11:32.000000000 +0100
@@ -303,7 +303,7 @@ void avtab_hash_eval(struct avtab *h, ch
 
 int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey)
 {
-	u32 buf[7];
+	__le32 buf[7];
 	u32 items, items2;
 	int rc;
 
@@ -370,7 +370,7 @@ int avtab_read(struct avtab *a, void *fp
 	int rc;
 	struct avtab_key avkey;
 	struct avtab_datum avdatum;
-	u32 buf[1];
+	__le32 buf[1];
 	u32 nel, i;
 
 
_
