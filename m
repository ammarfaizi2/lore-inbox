Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbRDMXWp>; Fri, 13 Apr 2001 19:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132399AbRDMXWd>; Fri, 13 Apr 2001 19:22:33 -0400
Received: from strauss.mileniumnet.com.br ([200.199.222.5]:19721 "EHLO
	strauss.mileniumnet.com.br") by vger.kernel.org with ESMTP
	id <S132398AbRDMXWO>; Fri, 13 Apr 2001 19:22:14 -0400
Date: Fri, 13 Apr 2001 19:21:42 -0400 (AMT)
From: Thiago Rondon <maluco@mileniumnet.com.br>
To: lkml <linux-kernel@vger.kernel.org>
cc: "Michael A. Griffith" <grif@acm.org>
Subject: [QUESTION] init/main.c
Message-ID: <Pine.LNX.4.21.0104131916150.11797-100000@freak.mileniumnet.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At function calibrate_delay(void) in init/main.c,
I dont understand this code:

<<EOF
                /* wait for "start of" clock tick */
                ticks = jiffies;
                while (ticks == jiffies)
                        /* nothing */;
                /* Go .. */

                ticks = jiffies; 
EOF

ticks = jiffies; while (ticks == jiffies); ticks = jiffies; ?

Thanks in advanced,
-Thiago Rondon

