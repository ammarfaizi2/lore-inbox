Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282784AbRLGG7a>; Fri, 7 Dec 2001 01:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285427AbRLGG7V>; Fri, 7 Dec 2001 01:59:21 -0500
Received: from mgr2.xmission.com ([198.60.22.202]:11786 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP
	id <S282784AbRLGG7J>; Fri, 7 Dec 2001 01:59:09 -0500
Message-ID: <3C1068BB.6070100@xmission.com>
Date: Thu, 06 Dec 2001 23:59:07 -0700
From: Ben Carrell <ben@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011202
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: make xconfig fails
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone else experiencing errors like the below when trying to run 
'make xconfig'.   I have tcl/tk install fine, I'm not sure what else to 
check...please help :)

root@london:/usr/src/linux# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.16/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
echo "set defaults \"arch/i386/defconfig\"" >> kconfig.tk
echo "set ARCH \"i386\"" >> kconfig.tk
cat tail.tk >> kconfig.tk
chmod 755 kconfig.tk
make[1]: Leaving directory `/usr/src/linux-2.4.16/scripts'
wish -f scripts/kconfig.tk
Application initialization failed: unknown color name "Black"
Error in startup script: can't invoke "button" command: application has 
been destroyed
    while executing
"button .ref"
    (file "scripts/kconfig.tk" line 51)
make: *** [xconfig] Error 1



