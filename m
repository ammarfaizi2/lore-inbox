Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279664AbRJYBHR>; Wed, 24 Oct 2001 21:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279665AbRJYBHH>; Wed, 24 Oct 2001 21:07:07 -0400
Received: from [63.220.7.190] ([63.220.7.190]:13014 "HELO gamerack.com")
	by vger.kernel.org with SMTP id <S279664AbRJYBGx>;
	Wed, 24 Oct 2001 21:06:53 -0400
Subject: Re: SiS/Trident 4DWave sound driver oops
From: "Michael F. Robbins" <compumike@compumike.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 24 Oct 2001 21:07:26 -0400
Message-Id: <1003972047.2393.9.camel@tbird.robbins>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a very similar OOPS that I reported to linux-kernel just last
week: see full details at
http://uwsg.iu.edu/hypermail/linux/kernel/0110.1/1690.html

> This kernel oops is totally reproducible (on every occasion) in 2.4.9,
> 2.4.10, and 2.4.12. I have not tried earlier kernels in the 2.4 
> series

I also have a totally reproduceable OOPS on 2.4.9 through 2.4.12. 
Kernel 2.4.7 works just fine.  If the soundcard is compiled in to the
kernel, it dies while booting.  If it is compiled as a module, it dies
when attempting to load the module (typically when artsd starts).

> The machine in question is a Clevo lp200t SiS630S "all-in-one" 
> machine.

My machine is an ECS K7AMA: ALi 1645 northbridge, ALi Magic 1535D+
southbridge.  Sound is onboard the southbridge.  I ran ksymoops on my
OOPS report, so you can see the trace at the message archive.

Mike Robbins
compumike@compumike.com
(Please also cc your reply to me.)


