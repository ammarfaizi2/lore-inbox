Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbSKKRjL>; Mon, 11 Nov 2002 12:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSKKRjL>; Mon, 11 Nov 2002 12:39:11 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:25254 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266453AbSKKRjL>;
	Mon, 11 Nov 2002 12:39:11 -0500
Message-ID: <3DCFEA8D.9070505@colorfullife.com>
Date: Mon, 11 Nov 2002 18:36:13 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Srinivasa T.N." <seenutn@cdotb.ernet.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: Increasing Message Queue's
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am using RH 7.2 (kernel 2.4.7-10)..
>	I wan't to increase the no. of message queues (right now it is MSGMNI = 
>16)..How to go about it??

As root [for example in /etc/rc.local]:
echo 128 > /proc/sys/kernel/msgnmi

Hmm. The documentation for both the sysv sem and the msg sysctl's is missing in linux/Documentation/sysrq/kernel.txt
--
	Manfred




