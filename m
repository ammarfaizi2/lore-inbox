Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284570AbRLZRKy>; Wed, 26 Dec 2001 12:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284584AbRLZRKp>; Wed, 26 Dec 2001 12:10:45 -0500
Received: from zeus.kernel.org ([204.152.189.113]:50125 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S284570AbRLZRKd>;
	Wed, 26 Dec 2001 12:10:33 -0500
Date: Wed, 26 Dec 2001 13:50:57 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Sebastian Wenleder <Sebastian@wenleder.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc2 oops
In-Reply-To: <p05100300b84e73ad5e5f@[192.168.100.2]>
Message-ID: <Pine.LNX.4.21.0112261350120.9852-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sebastian,

This looks like memory corruption of some kind...

Could you please run memtest86 on the box? 

Thanks

On Tue, 25 Dec 2001, Sebastian Wenleder wrote:

> Hi!
> 
> I received this oops after approx. 4 days uptime...
> gcc --version = 2.95.3
> 
> -
> ksymoops 2.4.1 on i686 2.4.17-rc2.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.17-rc2/ (default)
>      -m /boot/System.map-2.4.17-rc2 (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> No modules in ksyms, skipping objects
> Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
> Dec 25 18:48:22 asok kernel: Unable to handle kernel paging request at virtual address 63697233
> Dec 25 18:48:22 asok kernel: c013a000
> Dec 25 18:48:22 asok kernel: *pde = 00000000
> Dec 25 18:48:22 asok kernel: Oops: 0000
> Dec 25 18:48:22 asok kernel: CPU:    0
> Dec 25 18:48:22 asok kernel: EIP:    0010:[prune_dcache+16/328]    Not tainted
> Dec 25 18:48:22 asok kernel: EFLAGS: 00010a83

