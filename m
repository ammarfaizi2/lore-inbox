Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317469AbSGVPgW>; Mon, 22 Jul 2002 11:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSGVPgV>; Mon, 22 Jul 2002 11:36:21 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:26507 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317469AbSGVPgV>; Mon, 22 Jul 2002 11:36:21 -0400
Date: Mon, 22 Jul 2002 10:39:26 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: zhengchuanbo <zhengcb@netpower.com.cn>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: error when build linux-2.5.27
In-Reply-To: <200207221126411.SM00792@zhengcb>
Message-ID: <Pine.LNX.4.44.0207221035110.28150-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, zhengchuanbo wrote:

> 
> when i build linux-2.5.27,i met some problem. the error message is as this:
> 
> linux-kernelmake[1]: Entering directory `/usr/src/linux-2.5.27/arch/i386/kernel'
>   gcc -Wp,-MD,./.entry.o.d -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.5.27/i
> nclude -nostdinc -iwithprefix include  -traditional  -c -o entry.o entry.S
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/tradcpp0: Usage: /usr/lib/gcc-lib/i386-r
> edhat-linux/2.96/tradcpp0 [switches] input output
> make[1]: *** [entry.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.5.27/arch/i386/kernel'
> make: *** [arch/i386/kernel] Error 2

Hmmh, I have really no idea how that would happen, short of a compiler 
bug.

What version of gcc are you using? (2.96-X, it seems, what does "rpm -qa |
grep gcc" say?)

Does the error go away without the -traditional?

--Kai


