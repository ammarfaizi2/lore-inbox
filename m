Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSDXXXh>; Wed, 24 Apr 2002 19:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSDXXXg>; Wed, 24 Apr 2002 19:23:36 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:2690 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S312558AbSDXXXf>; Wed, 24 Apr 2002 19:23:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.9, 2.5.10 shellscript error
Date: Wed, 24 Apr 2002 17:17:14 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02042417171401.00760@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.5.10/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/isdn/Config.in: 10: incorrect argument
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.10/scripts'
make: *** [xconfig] Error 2


