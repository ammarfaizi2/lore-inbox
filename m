Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292880AbSB0Wkh>; Wed, 27 Feb 2002 17:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292918AbSB0Wjl>; Wed, 27 Feb 2002 17:39:41 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:46094 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S293018AbSB0Wim>; Wed, 27 Feb 2002 17:38:42 -0500
Message-ID: <3C7D5ED5.2030500@megapathdsl.net>
Date: Wed, 27 Feb 2002 14:33:57 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020217
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: 2.5.5-dj2 -- serial.c:649: too many arguments to function `handle_sysrq'
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.5-dj2 + nls.patch + migrate.diff + console_8.diff + roberto 
nibaldo's patches:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon 
-DKBUILD_BASENAME=serial  -DEXPORT_SYMTAB -c serial.c
serial.c: In function `receive_chars':
serial.c:649: too many arguments to function `handle_sysrq'
make[3]: *** [serial.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/char'

