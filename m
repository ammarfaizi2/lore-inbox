Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSGZCTg>; Thu, 25 Jul 2002 22:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSGZCTf>; Thu, 25 Jul 2002 22:19:35 -0400
Received: from naur.csee.wvu.edu ([157.182.194.28]:49892 "EHLO
	naur.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S316695AbSGZCTe>; Thu, 25 Jul 2002 22:19:34 -0400
Subject: Reg. gcc-3.0 for ultrasparc
From: Shanti Katta <katta@csee.wvu.edu>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 22:29:55 -0400
Message-Id: <1027650595.21198.13.camel@indus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
While compiling user-mode-linux on ultrasparc(with debian on it), I get
the following linker errors with gcc-3.0.

gcc-3.0 -Wl,-T,arch/um/link.ld  -Wl,--wrap,malloc -Wl,--wrap,free
-Wl,--wrap,calloc \
        -o linux -static arch/um/main.o vmlinux.o -L/usr/lib -lutil
/usr/bin/ld: skipping incompatible /usr/lib/libutil.a when searching for
-lutil

If I change that option to -L/usr/lib64, it gives a bunch of errors for
crti.o, crtbegin.o, etc and also complains about a bunch of functions in
vmlinux.o. Can anyone help in getting through these errors?
I was just wondering when the gcc-3.1 compiler will be ready for being
used on Ultrasparc?

Thanks in advance
-Regards
-Shanti

