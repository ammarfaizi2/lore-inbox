Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTFNW5H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 18:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTFNW5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 18:57:07 -0400
Received: from ethlife-a.ethz.ch ([129.132.202.7]:60059 "HELO lombi.mine.nu")
	by vger.kernel.org with SMTP id S261292AbTFNW5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 18:57:05 -0400
Mime-Version: 1.0
Message-Id: <p0432040bbb112c0ac508@[192.168.3.11]>
In-Reply-To: <20030613202205.GB22032@namesys.com>
References: <p04320407bb0f79fd523e@[192.168.3.11]>
 <20030613155634.GA18478@namesys.com> <20030613155934.GA19307@namesys.com>
 <p04320409bb0fb23f89f8@[192.168.3.11]>
 <20030613202205.GB22032@namesys.com>
Date: Sun, 15 Jun 2003 01:10:51 +0200
To: Oleg Drokin <green@namesys.com>
From: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Subject: Re: Lockups with loop'ed sparse files on reiserfs?
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 0:22 Uhr +0400 14.06.2003, Oleg Drokin wrote:
>Read /usr/src/linux/Documentation/sysrq.txt

Done, new kernels now compiled with CONFIG_MAGIC_SYSRQ.

>There were a known problem with reiserfs that it might sometimes
>deadlock in out-of-space situation.
>This is fixed in 2.4.21

Good to know.

>  > There's also the case 1, using uml. In this case I'm sure there was
>>  no problem with space. The sparse filesystem image file I used is
>  > exactly 500'000'000 bytes, and there's 1675228 k free space on the
>  > partition where it is put on.
>
>Ok, that's where sysrq-T/sysrq-P traceswould be most useful.
>And if you'd try with 2.4.21 that would be even better.

I've now compiled 2.4.21 from kernel.org with skas3 from debian, as 
well as 2.4.21 with grsecurity (from grsecurity.net, with medium 
setting) and skas3, and tried uml again with the same sparse image 
multiple times under both. I haven't managed to lock the machine up 
to now even while installing quite some stuff, so maybe the problem 
is already solved. If not, I'll tell you when it happens again. (I 
think I'll run 2.4.21-grsec-skas3 for the near future now.)

Thanks for your help
Christian.
