Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSCRVwq>; Mon, 18 Mar 2002 16:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293058AbSCRVwg>; Mon, 18 Mar 2002 16:52:36 -0500
Received: from ulima.unil.ch ([130.223.144.143]:8679 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S293048AbSCRVw0>;
	Mon, 18 Mar 2002 16:52:26 -0500
Date: Mon, 18 Mar 2002 22:52:21 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 hfs modules compil error
Message-ID: <20020318215221.GA942@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE
-DKBUILD_BASENAME=super  -c -o super.o super.c
super.c: In function `hfs_fill_super':
super.c:536: `sb' undeclared (first use in this function)
super.c:536: (Each undeclared identifier is reported only once
super.c:536: for each function it appears in.)
make[2]: *** [super.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5/fs/hfs'
make[1]: *** [_modsubdir_hfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/fs'
make: *** [_mod_fs] Error 2
178.340u 10.190s 3:15.77 96.3%  0+0k 0+0io 189688pf+0w
Exit 2

Thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
