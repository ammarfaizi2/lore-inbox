Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271514AbRHPHO3>; Thu, 16 Aug 2001 03:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271513AbRHPHOU>; Thu, 16 Aug 2001 03:14:20 -0400
Received: from [211.100.83.239] ([211.100.83.239]:14601 "HELO linux.tcpip.cxm")
	by vger.kernel.org with SMTP id <S271510AbRHPHON>;
	Thu, 16 Aug 2001 03:14:13 -0400
Date: Mon, 13 Aug 2001 21:46:38 +0800
From: hugang <linuxbest@soul.com.cn>
To: PinkFreud <pf-kernel@mirkwood.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast?
Message-Id: <20010813214638.3596b83a.linuxbest@soul.com.cn>
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net>
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net>
Organization: soul
X-Mailer: Sylpheed version 0.5.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001 03:43:05 -0400 (EDT)
PinkFreud <pf-kernel@mirkwood.net> wrote:

> 
> I have installed various 2.4.x kernels on 3 seperate systems here.  *ALL*
> of them have suffered from one malady or another - from the dual PIII with
> the VIA chipset and Matrox G400 card, which locks up nicely when I switch
> from X to a text console and back to X (but NOT under a uniprocessor
> kernel!), to the system with the NCR 53c810 SCSI board, which suffered
> random kernel panics anywhere from 2 hours to 5 days after booting, due to
> the ncr53c8xx driver, to YET ANOTHER system which has shown a penchant for
> crashing (read: no response on console, can use magic sysrq, but fails to
> emergency sync) when attempting to use 'ls' on a mounted QNX filesystem
> (ls comes up fine, then system crashes - nothing sent to syslog, no errors
> on screen, nothing!) - and this latest is with 2.4.8!
> 

> sauron@rivendell:~$ uptime
>  3:17AM  up 12 days, 15:20, 2 users, load averages: 1.48, 0.66, 0.31
> sauron@rivendell:~$ uname -a
> NetBSD rivendell 1.5.1 NetBSD 1.5.1 (RIVENDELL) #0: Tue Jul 31 22:58:54
> EDT 2001     root@rivendell:/usr/src/sys/arch/i386/compile/RIVENDELL i386
> sauron@rivendell:~$ dmesg | grep -i sym
> siop0 at pci0 dev 6 function 0: Symbios Logic 53c810 (fast scsi)
> 
> (The controller is old - it was made by NCR before it became Symbios Logic
> - hence, why I was using the NCR driver for it, rather than the Symbios
> driver, in Linux.)
> 
> Working on 13 days uptime.  That's well over twice the uptime for Linux on
> that box.  That's what happens when the kernel has bugs.
> 
> Take this rant for what you will.  Personally, I switched from Windows to
> Linux 5 years ago for the stability.  If I need to switch OSs again to
> continue to have stability, I will.  Somehow, I suspect, if kernel
> development continues down this path, many others will wind up switching
> to other OSs as well.
> 

	I think this problem can fix if your can report the crash message . (Oops,...)
Beacuse the netbsd can work fine on it , So I true the linux kernel also can  work fine on it.

-- 
Best Regard!
礼！
----------------------------------------------------
hugang : 胡刚 	GNU/Linux User
email  : gang_hu@soul.com.cn linuxbest@soul.com.cn
Tel    : +861068425741/2/3/4
Web    : http://www.soul.com.cn

	Beijing Soul technology Co.Ltd.
	   北京众志和达科技有限公司
----------------------------------------------------
