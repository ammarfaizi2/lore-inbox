Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVCXPaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVCXPaE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVCXP3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:29:14 -0500
Received: from geode.he.net ([216.218.230.98]:5648 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262563AbVCXPXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:23:37 -0500
From: ecashin@noserose.net
Message-Id: <1111677815.30696@geode.he.net>
Date: Thu, 24 Mar 2005 07:23:35 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [8/12]: document env var for specifying number of partitions per dev
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


document env var for specifying number of partitions per dev

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/Documentation/aoe/mkdevs.sh b/Documentation/aoe/mkdevs.sh
--- a/Documentation/aoe/mkdevs.sh	2005-03-07 17:37:14.000000000 -0500
+++ b/Documentation/aoe/mkdevs.sh	2005-03-10 12:19:56.000000000 -0500
@@ -5,6 +5,7 @@ n_partitions=${n_partitions:-16}
 
 if test "$#" != "1"; then
 	echo "Usage: sh `basename $0` {dir}" 1>&2
+	echo "       n_partitions=16 sh `basename $0` {dir}" 1>&2
 	exit 1
 fi
 dir=$1
diff -uprN a/Documentation/aoe/mkshelf.sh b/Documentation/aoe/mkshelf.sh
--- a/Documentation/aoe/mkshelf.sh	2005-03-07 17:37:14.000000000 -0500
+++ b/Documentation/aoe/mkshelf.sh	2005-03-10 12:19:56.000000000 -0500
@@ -2,6 +2,7 @@
 
 if test "$#" != "2"; then
 	echo "Usage: sh `basename $0` {dir} {shelfaddress}" 1>&2
+	echo "       n_partitions=16 sh `basename $0` {dir} {shelfaddress}" 1>&2
 	exit 1
 fi
 n_partitions=${n_partitions:-16}


-- 
  Ed L. Cashin <ecashin@coraid.com>
