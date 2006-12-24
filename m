Return-Path: <linux-kernel-owner+w=401wt.eu-S1751949AbWLXOkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbWLXOkz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 09:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWLXOkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 09:40:55 -0500
Received: from smtp.nildram.co.uk ([195.112.4.54]:3736 "EHLO
	smtp.nildram.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbWLXOky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 09:40:54 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.19.1
Date: Sun, 24 Dec 2006 14:40:55 +0000
User-Agent: KMail/1.9.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200612232325_MC3-1-D634-10E4@compuserve.com>
In-Reply-To: <200612232325_MC3-1-D634-10E4@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612241440.55841.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 December 2006 04:23, Chuck Ebbert wrote:
> In-Reply-To: <200612231540.47176.s0348365@sms.ed.ac.uk>
>
> On Sat, 23 Dec 2006 15:40:46 +0000, Alistair John Strachan wrote:
> > Pretty much like clockwork, it happened again. I think it's time to take
> > this seriously as a software bug, and not some hardware problem. I've ran
> > kernels since 2.6.0 on this machine without such crashes, and now two of
> > the same in 2.6.19.1? Pretty unlikely!
>
> Stranger things have happened, e.g. your system might have started
> to overheat just recently.

True, I've considered it, I'll replace the CPU fan.

> Anyway, post your complete .config.  And exactly which one of the
> many Via cpus are you using?  Are you using the Padlock unit?

No, much older than that:

[alistair] 14:38 [~] cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 9
model name      : VIA Nehemiah
stepping        : 1
cpu MHz         : 999.569
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge cmov mmx fxsr sse fxsr_opt
bogomips        : 2000.02

> What do those java/python programs do that are running?  What pipe
> are they polling?
>
> You could try going back to 2.6.18.x for a while in the meantime.

Well, I have had a thought. I recently upgraded the toolchain on the machine 
from binutils 2.16.x and GCC 3.4.3 (2.6.19 was built with this) to binutils 
2.17 and GCC 4.1.1. It's conceivable that this is some sort of compiler bug.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
