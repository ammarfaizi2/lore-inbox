Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317389AbSGUVCY>; Sun, 21 Jul 2002 17:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317405AbSGUVCY>; Sun, 21 Jul 2002 17:02:24 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:8183 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317389AbSGUVCX>; Sun, 21 Jul 2002 17:02:23 -0400
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
In-Reply-To: <Pine.LNX.4.44.0207212249070.26468-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0207212249070.26468-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 23:17:44 +0100
Message-Id: <1027289864.16819.117.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 21:50, Ingo Molnar wrote:
> 
> fixed the arch/i386/kernel/mca.c hacks as well:
>  
>      http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-A6
> 
> while there cannot be many MCA SMP boxes in existence, it should be SMP
> safe as well.

The NCR boxes and the 9595 are probably about it. There are plenty of
9595's around but if you ever acquire one make sure someone else is
paying postage 8)

