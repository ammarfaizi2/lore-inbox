Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSE2TXC>; Wed, 29 May 2002 15:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSE2TXB>; Wed, 29 May 2002 15:23:01 -0400
Received: from lafontaine.noos.net ([212.198.2.72]:32006 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S315439AbSE2TXA>;
	Wed, 29 May 2002 15:23:00 -0400
Message-ID: <3CF52841.8040507@noos.fr>
Date: Wed, 29 May 2002 21:13:05 +0200
From: "Christian.Gennerat" <xgen@noos.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: fr-fr
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Kernel zombie threads after module removal.
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is very close to the problem related in 
http://lkml.org/archive/2002/2/4/368/index.html
but I have no USB. I have SCSI with aha152x_cs.o,
and after doing "cardctl eject" that removes the module,
the process scsi_eh_0  stays as zombie.
If I repeat the operation of card insert and eject,
I get  several  scsi_eh_0  zombies.

Now  with 2.4.18, but  I have got this problem with others 2.4 kernels.


