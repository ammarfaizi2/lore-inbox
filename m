Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSKNTmT>; Thu, 14 Nov 2002 14:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbSKNTmT>; Thu, 14 Nov 2002 14:42:19 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:46764 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264749AbSKNTmS>; Thu, 14 Nov 2002 14:42:18 -0500
Subject: Re: [patch] remove hugetlb syscalls
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David.Mosberger@acm.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3DD3F960.6000501@pobox.com>
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com>	<08a601c28bb
	b$2f6182a0$760010ac@edumazet>	<20021114141310.A25747@infradead.org>	<ugel9oa
	vk4.fsf@panda.mostang.com>	<1037298675.16000.47.camel@irongate.swansea.linux
	 .org.uk> <15827.61722.800066.756875@panda.mostang.com> 
	<3DD3F960.6000501@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Nov 2002 20:15:06 +0000
Message-Id: <1037304906.16000.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-14 at 19:28, Jeff Garzik wrote:
> However, that said, I think hugetlbfs will almost always get used in 
> preference to the syscalls, so leaving them in may be more a statement 
> of technical correctness/cleanliness than anything else.

Just rewrite the syscall crap in userspace as library functions calling
hugetlbfs. End of problem, less kernel code, less bugs, same interface

