Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316666AbSE1Oui>; Tue, 28 May 2002 10:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316668AbSE1Ouh>; Tue, 28 May 2002 10:50:37 -0400
Received: from mx1.mail.ru ([194.67.57.11]:7953 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id <S316666AbSE1Oug>;
	Tue, 28 May 2002 10:50:36 -0400
Date: Tue, 28 May 2002 18:46:43 +0400
From: Dmitry Volkoff <vdb@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
Message-ID: <20020528184643.A796@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Unfortunately, the memory management of kernel 2.4.x didn't get better until 
> today. It is very easy to make a machine dead. Take the following script: 
> 
> http://groups.google.com/groups?q=malloc+bestie&hl=de&lr=&selm=slrn8aiglm.tqd.pfk@c.zeiss.de&rnum=2 
> 
> The result with kernel 2.4.19pre8ac4: 

What about results with latest -aa kernels? 
I'm writing this letter while running your killer-test ;)
My machine is perfectly responsive.

$ uname -a
Linux localhost 2.4.19-pre6vm33 #2 Sat Apr 13 00:56:55 MSD 2002 i686 unknown
This is vanilla 2.4.19-pre6 + vm33 from Andrea Arcangelly.

Funny stats:

bash-2.05$ free
total       used       free     shared    buffers     cached
Mem:        516496     512804       3692          0       2080      10064
-/+ buffers/cache:     500660      15836
Swap:      1028120    1028120          0

I'm running X, netscape, mutt, top, 5 xterms, web, mysql, ftp, samba etc.
Lots of "0-order allocation failed" in the log. Anyway it is usable!
The good thing is VM is killing right process most of the time: 

VM: killing process memory-killer

Netscape got killed. Big deal, I can start it again and it works... 

P.S. Running it already for 20 minutes.

-- 

    DV
