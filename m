Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTD1X7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbTD1X7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:59:54 -0400
Received: from smtp4.wanadoo.es ([62.37.236.138]:32950 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S261414AbTD1X7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:59:53 -0400
Message-ID: <3EADC355.5070305@wanadoo.es>
Date: Tue, 29 Apr 2003 02:12:05 +0200
From: =?ISO-8859-1?Q?xos=E9_v=E1zquez_p=E9rez?= <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [ Compile Regression on i386 ]-2.4.21-rc1-ac3 _critical_ compile
 errors
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel compilation output summary:

--drivers/char/ipmi--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=ipmi_kcs_intf  -c -o ipmi_kcs_intf.o ipmi_kcs_intf.c
ipmi_kcs_intf.c:1035:42: ../drivers/acpi/include/acpi.h: No such file or directory
ipmi_kcs_intf.c:1036:45: ../drivers/acpi/include/actypes.h: No such file or directory
ipmi_kcs_intf.c: In function `acpi_find_bmc':
ipmi_kcs_intf.c:1061: `acpi_table_header' undeclared (first use in this function)
ipmi_kcs_intf.c:1061: (Each undeclared identifier is reported only once
ipmi_kcs_intf.c:1061: for each function it appears in.)
ipmi_kcs_intf.c:1061: `spmi' undeclared (first use in this function)
ipmi_kcs_intf.c:1061: warning: statement with no effect
ipmi_kcs_intf.c:1062: parse error before `static'
ipmi_kcs_intf.c:1064: `io_base' undeclared (first use in this function)
ipmi_kcs_intf.c:1079: warning: control reaches end of non-void function
make[2]: [ipmi_kcs_intf.o] Error 1 (ignored)
--end--

--fs/devpts--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=inode -c -o inode.o inode.c
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



