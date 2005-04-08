Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVDHH5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVDHH5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVDHH5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:57:52 -0400
Received: from coderock.org ([193.77.147.115]:5856 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262738AbVDHHvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:51:05 -0400
Subject: [patch 2/8] correctly name the Shell sort
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, didickman@yahoo.com
From: domen@coderock.org
Date: Fri, 08 Apr 2005 09:50:53 +0200
Message-Id: <20050408075054.25DF41F3A3@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



As per http://www.nist.gov/dads/HTML/shellsort.html, this should be referred to
as a Shell sort. Shell-Metzner is a misnomer.

Signed-off-by: Daniel Dickman <didickman@yahoo.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/kernel/sys.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/sys.c~comment-kernel_sys kernel/sys.c
--- kj/kernel/sys.c~comment-kernel_sys	2005-04-05 12:57:41.000000000 +0200
+++ kj-domen/kernel/sys.c	2005-04-05 12:57:41.000000000 +0200
@@ -1194,7 +1194,7 @@ static int groups_from_user(struct group
 	return 0;
 }
 
-/* a simple shell-metzner sort */
+/* a simple Shell sort */
 static void groups_sort(struct group_info *group_info)
 {
 	int base, max, stride;
_
