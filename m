Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313385AbSDES2C>; Fri, 5 Apr 2002 13:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313392AbSDES1w>; Fri, 5 Apr 2002 13:27:52 -0500
Received: from line106-150.adsl.actcom.co.il ([192.117.106.150]:19593 "HELO
	mail.bard.org.il") by vger.kernel.org with SMTP id <S313385AbSDES1k>;
	Fri, 5 Apr 2002 13:27:40 -0500
Date: Fri, 5 Apr 2002 21:27:31 +0300
From: "Marc A. Volovic" <marc@bard.org.il>
To: Albert Max Lai <amlai@bitsorcery.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x and DAC960 issues
Message-ID: <20020405182731.GA20224@glamis.bard.org.il>
In-Reply-To: <15533.14286.502083.225297@bitsorcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux glamis.bard.org.il 2.4.19-pre5
X-message-flag: 'Oi! Muy Importante! Get yourself a real email client. http://www.mutt.org/'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Max Lai said:

> I have had problems using the DAC960 driver under any 2.4.x kernel
> (currently using 2.4.18).  I have not experienced these problems under
> 
> 1.  Under reasonably low loads the driver will hang.  It is very
>     reproducible when using the benchmark program "Bonnie."  This
[snip]
>     problem is exacerbated when using the ext3 filing system, locking

I am using a Mylex 170LP with no problem, running on a dual 550MHz 
MSI 6120S under quite a few 2.4.x kernels, lately 2.4.18 and 2.4.19pre5,
all under reiserfs.  The firmware is 6.00-15, carrying 6 9GB disks
(5 RAID5 + 1 spare).

There have been NO lockups under any version of the kernel, not under 
multiple bonnie runs.

What is your interrupt breakdown? Could your machine be doing something
naughty with the interrupts?

---MAV
                       Linguists Do It Cunningly
Marc A. Volovic                                          marc@bard.org.il
