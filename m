Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273256AbRIRJWu>; Tue, 18 Sep 2001 05:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273254AbRIRJWk>; Tue, 18 Sep 2001 05:22:40 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:26635 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S273258AbRIRJWc> convert rfc822-to-8bit;
	Tue, 18 Sep 2001 05:22:32 -0400
Date: Tue, 18 Sep 2001 12:22:48 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: <linux-kernel@vger.kernel.org>
Subject: Module-loading problem with 4MB of ram
Message-ID: <Pine.LNX.4.33.0109181217330.4235-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I have a machine with only 4MB of RAM. I'm using kernel 2.2.19.

System starts up just fine, and I can load pcmcia-cs. Now, when I insert
pcmcia-card, the card is detected, and the loading of driver is started.

This is where the problems start. Driver says it cannot allocate memory
for the firmware of the card. When I look at the code, it is like this:

ptr = dmalloc(size, GFP_ATOMIC);

is there any way to reserve some memory for the driver-module?


Thank you for your help.


- Pasi Kärkkäinen
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

