Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310258AbSCPLWS>; Sat, 16 Mar 2002 06:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310257AbSCPLWI>; Sat, 16 Mar 2002 06:22:08 -0500
Received: from [210.19.28.11] ([210.19.28.11]:43396 "EHLO dZuRa.Vault-ID.com")
	by vger.kernel.org with ESMTP id <S310255AbSCPLVv>;
	Sat, 16 Mar 2002 06:21:51 -0500
Date: Sat, 16 Mar 2002 19:18:41 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org
Subject: linux 2.5.7-pre2 make xconfig error
Message-Id: <20020316191841.724970e7.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
User-Agent: Half Life (Build 1760)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux/scripts'
cat header.tk >> ./kconfig.tk
../tkparse < ../arch/i386/config.in >> kconfig.tk
sound/core/Config.in: 4: can't handle dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux/scripts'
make: *** [xconfig] Error 2


Regards,

-Ubaida-
