Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbSJ2Q7Z>; Tue, 29 Oct 2002 11:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJ2Q7Y>; Tue, 29 Oct 2002 11:59:24 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:8708
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262248AbSJ2Q7W>; Tue, 29 Oct 2002 11:59:22 -0500
Subject: [patch] overcommit-accounting doc fix
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Cc: Kenny Simpson <theonetruekenny@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1035884025.5852.4.camel@irongate.swansea.linux.org.uk>
References: <20021029031918.43126.qmail@web20008.mail.yahoo.com> 
	<1035884025.5852.4.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Oct 2002 12:05:31 -0500
Message-Id: <1035911132.757.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-29 at 04:33, Alan Cox wrote:

> On Tue, 2002-10-29 at 03:19, Kenny Simpson wrote:
>
> > Where is number 3 ?
> 
> Robert removed number 3 from 2.5 and I guess he missed one of the
> comments 8)

Whoops - documentation fix attached :)

	Robert Love

 Documentation/overcommit-accounting |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-2.5.44/Documentation/vm/overcommit-accounting linux/Documentation/vm/overcommit-accounting
--- linux-2.5.44/Documentation/vm/overcommit-accounting	2002-10-19 00:01:18.000000000 -0400
+++ linux/Documentation/vm/overcommit-accounting	2002-10-29 12:03:13.000000000 -0500
@@ -1,4 +1,4 @@
-The Linux kernel supports four overcommit handling modes
+The Linux kernel supports three overcommit handling modes
 
 0	-	Heuristic overcommit handling. Obvious overcommits of
 		address space are refused. Used for a typical system. It

