Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310393AbSBRKaC>; Mon, 18 Feb 2002 05:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310397AbSBRK3w>; Mon, 18 Feb 2002 05:29:52 -0500
Received: from bpdcwm01.bpcl.broadband.hu ([195.184.181.2]:40604 "HELO
	mx01.broadband.hu") by vger.kernel.org with SMTP id <S310393AbSBRK3k>;
	Mon, 18 Feb 2002 05:29:40 -0500
Message-ID: <3C70D70A.5050507@mail.externet.hu>
Date: Mon, 18 Feb 2002 11:27:22 +0100
From: Boszormenyi Zoltan <zboszor@mail.externet.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011014
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rtctimer.c does not compile
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am trying to compile 2.5.5-pre1 but sound/core/rtctimer.c does not 
compile.
It can be solved with two steps.

1. Patch the kernel with 
alsa-driver-0.9.0beta11/utils/patches/rtc-2.4.16.patch.
2. Add #include <linux/interrupt.h> to sound/core/rtctimer.c.

Best regards,
Zoltán Böszörményi


