Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289585AbSAOOOy>; Tue, 15 Jan 2002 09:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289642AbSAOOOk>; Tue, 15 Jan 2002 09:14:40 -0500
Received: from mgr2.xmission.com ([198.60.22.202]:36881 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP
	id <S289585AbSAOOO0>; Tue, 15 Jan 2002 09:14:26 -0500
Message-ID: <3C443940.8070000@xmission.com>
Date: Tue, 15 Jan 2002 07:14:24 -0700
From: Frank Jacobberger <f1j@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011225
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: emu10k1_audio_open?? 2.5.2 problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5.2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.5.2/include/linux/modversions.h   -c -o audio.o audio.c
audio.c: In function `emu10k1_audio_open':
audio.c:1101: invalid operands to binary &
make[3]: *** [audio.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.2/drivers/sound/emu10k1'
make[2]: *** [_modsubdir_emu10k1] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.2/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.2/drivers'
make: *** [_mod_drivers] Error 2

What to do?

Thanks,

Frank

