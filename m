Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbRABCHe>; Mon, 1 Jan 2001 21:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbRABCH0>; Mon, 1 Jan 2001 21:07:26 -0500
Received: from c252.h203149202.is.net.tw ([203.149.202.252]:57855 "EHLO
	mail.tahsda.org.tw") by vger.kernel.org with ESMTP
	id <S130073AbRABCHN>; Mon, 1 Jan 2001 21:07:13 -0500
Message-ID: <3A513089.9AF6EB6A@teatime.com.tw>
Date: Tue, 02 Jan 2001 09:36:09 +0800
From: Tommy Wu <tommy@teatime.com.tw>
Reply-To: tommy@teatime.com.tw
Organization: TeaTime Development
X-Mailer: Mozilla 4.76 [zh] (Windows NT 5.0; U)
X-Accept-Language: en,zh,zh-TW,zh-CN
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Sparc64 compile error for 2.4.0-prerelease
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Entering directory `/usr/src/kernel-source-2.4.0-prerelease/kernel'
sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototype
s -O2 -fomit-frame-pointer -fno-strict-aliasing -m64 -pipe -mno-fpu -mcpu=ultras
parc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare
-Wa,--undeclared-regs    -c -o panic.o panic.c
panic.c: In function `panic':
panic.c:80: `loops_per_sec' undeclared (first use in this function)
panic.c:80: (Each undeclared identifier is reported only once
panic.c:80: for each function it appears in.)
make[2]: *** [panic.o] Error 1
make[2]: Leaving directory `/usr/src/kernel-source-2.4.0-prerelease/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/kernel-source-2.4.0-prerelease/kernel'
make: *** [_dir_kernel] Error 2


-- 

    Tommy Wu
    mailto:tommy@teatime.com.tw
    http://www.teatime.com.tw/~tommy
    ICQ: 22766091
    Mobile Phone: +886 936 909490
    TeaTime BBS +886 2 31515964 24Hrs V.Everything

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
