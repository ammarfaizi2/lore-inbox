Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbTDWVv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTDWVv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:51:56 -0400
Received: from [12.46.110.22] ([12.46.110.22]:64391 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264269AbTDWVvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:51:55 -0400
Subject: Is anyone manitaing make xconfig?
From: "B. Joshua Rosen" <bjrosen@polybus.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Polybus Systems Corp
Message-Id: <1051135494.4872.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Apr 2003 18:04:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make xconfig has been broken for some time now, is anyone still
maintaining it? I contacted the listed maintainer, Michael Elizabeth
Chastain, who said that she is no longer maintaining it. 

Make xconfig is pretty important, it's hard to imagine that it's going
to be allowed to rot.

Here is the compile error for 2.4.21-rc1,

/home/tmp/linux-2.4.20> make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/home/tmp/linux-2.4.20/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/ide/Config.in: 46: can't handle dep_bool/dep_mbool/dep_tristate
condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/home/tmp/linux-2.4.20/scripts'
make: *** [xconfig] Error 2

Thanks,

Josh

-- 
B. Joshua Rosen <bjrosen@polybus.com>
Polybus Systems Corp
