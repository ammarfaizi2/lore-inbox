Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279982AbRKHC4I>; Wed, 7 Nov 2001 21:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281326AbRKHCz6>; Wed, 7 Nov 2001 21:55:58 -0500
Received: from zok.sgi.com ([204.94.215.101]:1495 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S279982AbRKHCzt>;
	Wed, 7 Nov 2001 21:55:49 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Pam <xanni@glasswings.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipchains.o dependencies problem from 1999 (!) returns in 2.4.14 kernel 
In-Reply-To: Your message of "Thu, 08 Nov 2001 12:58:51 +1100."
             <20011108125851.K673@kira.glasswings.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 08 Nov 2001 13:55:39 +1100
Message-ID: <9218.1005188139@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001 12:58:51 +1100, 
Andrew Pam <xanni@glasswings.com.au> wrote:
>In the 2.4.14 kernel, I get the following dependency problems with ipchains.o:
>
>[root@TekTih root]# depmod -ae
>depmod: *** Unresolved symbols in /lib/modules/2.4.14+ext3/kernel/net/ipv4/netfilter/ipchains.o
>depmod:         netlink_kernel_create
>depmod:         netlink_broadcast

Works for me with your config.  At a guess, you have been bitten by the
broken kernel Makefiles - http://www.tux.org/lkml/#s8-8

