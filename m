Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTDYTZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 15:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTDYTZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 15:25:49 -0400
Received: from smtp3.wanadoo.es ([62.37.236.137]:43449 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S263680AbTDYTZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 15:25:48 -0400
Message-ID: <3EA98E8A.1090100@wanadoo.es>
Date: Fri, 25 Apr 2003 21:37:46 +0200
From: =?ISO-8859-1?Q?xos=E9_v=E1zquez_p=E9rez?= <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, marcelo@conectiva.com.br
Subject: [ Compile Regression on i386 ]-2.4.21-rc1 _critical_ compile errors
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel compilation output summary:

--fs/devpts--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=inode  -c -o inode.o inode.c
inode.c: In function `init_devpts_fs':
inode.c:233: `devpts_upcall_new' undeclared (first use in this function)
inode.c:233: (Each undeclared identifier is reported only once
inode.c:233: for each function it appears in.)
inode.c:234: `devpts_upcall_kill' undeclared (first use in this function)
inode.c: In function `exit_devpts_fs':
inode.c:244: `devpts_upcall_new' undeclared (first use in this function)
inode.c:245: `devpts_upcall_kill' undeclared (first use in this function)
make[1]: [inode.o] Error 1 (ignored)
--end--

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!

