Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290742AbSAYRcS>; Fri, 25 Jan 2002 12:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290743AbSAYRcI>; Fri, 25 Jan 2002 12:32:08 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:21514 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S290742AbSAYRcD>; Fri, 25 Jan 2002 12:32:03 -0500
Subject: Re: 2.5.3-pre5 -- "pcilynx.c:638: invalid operands to binary &" 
	and  "pcilynx.c:650: `cards' undeclared"
From: Miles Lane <miles@megapathdsl.net>
To: johnpol@2ka.mipt.ru
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020125123711.0f0ebc61.johnpol@2ka.mipt.ru>
In-Reply-To: <1011932306.18088.162.camel@stomata.megapathdsl.net> 
	<20020125123711.0f0ebc61.johnpol@2ka.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 25 Jan 2002 09:30:50 -0800
Message-Id: <1011979851.1261.9.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeniy,

I get this error with the patch applied:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o
pcilynx.o pcilynx.c
pcilynx.c: In function `mem_open':
pcilynx.c:644: invalid operands to binary &
pcilynx.c: In function `add_card':
pcilynx.c:1520: incompatible types in assignment
make[2]: *** [pcilynx.o] Error 1

Thanks,
	Miles


