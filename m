Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263146AbTCLLQs>; Wed, 12 Mar 2003 06:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263147AbTCLLQs>; Wed, 12 Mar 2003 06:16:48 -0500
Received: from ATuileries-102-2-1-196.abo.wanadoo.fr ([193.251.178.196]:3222
	"EHLO mojito.idtect.net") by vger.kernel.org with ESMTP
	id <S263146AbTCLLQr>; Wed, 12 Mar 2003 06:16:47 -0500
Message-ID: <3E6F199E.5000001@ruault.com>
Date: Wed, 12 Mar 2003 12:27:26 +0100
From: Charles-Edouard Ruault <kernel@ruault.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [kernel 2.4.21-pre5 : process stuck in D state
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

i've been running kernel 2.4.21-preX series for a while on my ASUS A7V8X 
motherboard ( with an athlon XP 2400+ )  and i've noticed the following 
annoying problem.
Very often, mozilla ( 1.2.1 ) dies and is stuck in D state, waiting on a 
semaphore, here's the output of ps :

ps -elf | grep mozill
000 S userX 2615  1462  0  69   0    -   972 wait4  00:50 ? 
00:00:00 /bin/sh /usr/local/mozilla/run-mozilla.sh 
/usr/local/mozilla/mozilla-bin
000 D userX   2621  2615  0  69   0    - 13623 down   00:50 ? 
00:00:02 /usr/local/mozilla/mozilla-bin

Has anyone noticed the same behaviour ? Is this a well known problem ?
Thanks for your help.
Regards

Charles-Edouard Ruault

