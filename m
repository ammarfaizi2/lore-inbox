Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318607AbSH1D3d>; Tue, 27 Aug 2002 23:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318622AbSH1D3d>; Tue, 27 Aug 2002 23:29:33 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:41934 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318607AbSH1D3d>; Tue, 27 Aug 2002 23:29:33 -0400
Message-ID: <3D6C449A.E2B67658@attbi.com>
Date: Tue, 27 Aug 2002 23:33:46 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [patch]2.5.32 scsi/st.c "parse error before ;" line 112
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
2.5.32 compile error scsi tape line 112 "parse error before ;"
Please apply this tested simple fix.
Albert
--- linux2.5.32/drivers/scsi/st.c.orig        2002-08-27 23:14:18.000000000 -0400
+++ linux/drivers/scsi/st.c     2002-08-27 23:14:29.000000000 -0400
@@ -109,6 +109,7 @@
        },
        {
                "try_direct_io", &try_direct_io
+       }
 };
 #endif
 

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
