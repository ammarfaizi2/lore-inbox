Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbRCULOP>; Wed, 21 Mar 2001 06:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRCULOH>; Wed, 21 Mar 2001 06:14:07 -0500
Received: from zeus.kernel.org ([209.10.41.242]:61395 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131341AbRCULN4>;
	Wed, 21 Mar 2001 06:13:56 -0500
Date: Wed, 21 Mar 2001 22:00:51 +0530 (IST)
From: Manoj Sontakke <manojs@sasken.com>
To: linux-kernel@vger.kernel.org
Subject: initialisation code
Message-ID: <Pine.LNX.4.21.0103212147400.884-100000@pcc65.sasi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
	I am trying to implement some QoS in kernel(in the IP
layer....similar to TC..... BTW  TC works in the data-link layer). I am
dequeuing the packets from the IP queue when the function ip_forward is
called. After processing them, I am reinserting them back to the IP queue.
	I have a initlisation function (just like pktsched_init in
TC). Can anyone tell me, where in the kernel boot sequence should I make a
call to my initialisation function.

Thanks in advance for all the help. 

Manoj

