Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTEaWZq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 18:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbTEaWZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 18:25:46 -0400
Received: from [62.37.236.142] ([62.37.236.142]:17400 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S264479AbTEaWZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 18:25:45 -0400
Message-ID: <3ED92EEC.8050107@wanadoo.es>
Date: Sun, 01 Jun 2003 00:38:36 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [ Compile Regression on i386 ]-2.4.21-rc6-ac1 _critical_ compilation
 errors
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel compilation output summary:

--drivers/hotplug/acpiphp_glue.c--
gcc -D__KERNEL__ -I/datos/kernel/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=acpiphp_glue  -c -o acpiphp_glue.o acpiphp_glue.c
acpiphp_glue.c: In function `find_host_bridge':
acpiphp_glue.c:815: warning: passing arg 2 of `acpi_get_object_info' from incompatible pointer type
acpiphp_glue.c:821: subscripted value is neither array nor pointer
acpiphp_glue.c:826: incompatible type for argument 1 of `strcmp'
make[2]: *** [acpiphp_glue.o] Error 1
--end--

regards,
--
Software is like sex, it's better when it's bug free.

