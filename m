Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUCPUgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbUCPUgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:36:20 -0500
Received: from mail.gmx.de ([213.165.64.20]:59340 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261648AbUCPUgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:36:17 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Steve Youngs <sryoungs@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: NVIDIA and 2.6.4?
Date: Tue, 16 Mar 2004 21:49:40 +0100
User-Agent: KMail/1.6.1
References: <405082A2.5040304@blueyonder.co.uk> <200403130515.i2D5F7DG009253@turing-police.cc.vt.edu> <microsoft-free.87ad2ipyr2.fsf@eicq.dnsalias.org>
In-Reply-To: <microsoft-free.87ad2ipyr2.fsf@eicq.dnsalias.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403162149.41018.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 March 2004 04:36, Steve Youngs wrote:
> * Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:
>   > On Fri, 12 Mar 2004 18:24:01 GMT, Adam Jones <adam@yggdrasl.demon.co.uk>  
said:
>   >> A quick thought - have you got CONFIG_REGPARM enabled in the kernel
>   >> config?  If so, disable it and try again.  (It's almost certain to
>   >> cause crashes with binary modules.)
>
>   $ zgrep REGPARM /proc/config.gz
> CONFIG_REGPARM=y
>
>   $ grep nvidia /proc/modules
> nvidia 2066568 22 - Live 0xe0b2d000
>
>   $ uname -r
> 2.6.4-sy1
>
> No problems here. :-)
>
>   > Also, the NVidia driver uses a bit of kernel stack, so it's
>   > incompatible with the CONFIG_4KSTACKS option in recent -mm
>   > kernels...
>
> Will have to remember that for 2.6.5, I'll let you know how it goes.
> Thanks, Valdis.

can you let me know how to compile the nvidia drivers for 4KSTACK? cause in 
the 2.6.5-rc1-mm1 is no more option to deactivate 4KSTACK.
thx!

greets
