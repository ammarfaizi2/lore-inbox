Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280808AbRKBTj2>; Fri, 2 Nov 2001 14:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280809AbRKBTjS>; Fri, 2 Nov 2001 14:39:18 -0500
Received: from freeside.toyota.com ([63.87.74.7]:35087 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S280808AbRKBTjG>;
	Fri, 2 Nov 2001 14:39:06 -0500
Message-ID: <3BE2F649.11E7D95F@lexus.com>
Date: Fri, 02 Nov 2001 11:38:49 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre7-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael H. Warfield" <mhw@wittsend.com>
CC: Sebastian =?iso-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre7 Unresolved symbols
In-Reply-To: <200111020954.fA29sf413054@riker.skynet.be> <20011102102140Z280638-17408+9329@vger.kernel.org> <20011102135153.B24959@alcove.wittsend.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trivial patch, "works for me" (tm) -

diff -urN linux/kernel/ksyms.c linux-patched/kernel/ksyms.c
--- linux/kernel/ksyms.c Fri Nov  2 11:02:45 2001
+++ linux-patched/kernel/ksyms.c Fri Nov  2 10:09:48 2001
@@ -83,6 +83,7 @@
 EXPORT_SYMBOL(do_mmap_pgoff);
 EXPORT_SYMBOL(do_munmap);
 EXPORT_SYMBOL(do_brk);
+EXPORT_SYMBOL(unlock_page);
 EXPORT_SYMBOL(exit_mm);
 EXPORT_SYMBOL(exit_files);
 EXPORT_SYMBOL(exit_fs);


