Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288460AbSAQKca>; Thu, 17 Jan 2002 05:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288466AbSAQKcU>; Thu, 17 Jan 2002 05:32:20 -0500
Received: from [195.163.91.180] ([195.163.91.180]:18954 "EHLO frontpartner.com")
	by vger.kernel.org with ESMTP id <S288460AbSAQKcL> convert rfc822-to-8bit;
	Thu, 17 Jan 2002 05:32:11 -0500
From: Mathias Wiklander <linuxkernel@frontpartner.com>
Date: Thu, 17 Jan 2002 11:32:04 +0100
To: linux-kernel@vger.kernel.org
Cc: eastbay@exadus.com
Subject: 2.5.3-pre1 emu10k1
Message-ID: <20020117103204.GA8938@profive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to compile emu10k1 as a module i get this error.

gcc -D__KERNEL__ -I/usr/src/v2.5.2/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-
strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-DMODULE -DEMU10K1_SEQUENCER  -c -o audio.o a
udio.c
audio.c: In function mu10k1_audio_open':
audio.c:1101: invalid operands to binary &
make[3]: *** [audio.o] Error 1
make[3]: Leaving directory /usr/src/v2.5.2/linux/drivers/sound/emu10k1'

/Eastbay
