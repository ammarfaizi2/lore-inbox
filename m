Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbSKNR6X>; Thu, 14 Nov 2002 12:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265184AbSKNR6X>; Thu, 14 Nov 2002 12:58:23 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:33452 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265177AbSKNR6V>; Thu, 14 Nov 2002 12:58:21 -0500
Subject: Re: [patch] remove hugetlb syscalls
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ugel9oavk4.fsf@panda.mostang.com>
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com>
	<08a601c28bbb$2f6182a0$760010ac@edumazet>
	<20021114141310.A25747@infradead.org>  <ugel9oavk4.fsf@panda.mostang.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Nov 2002 18:31:15 +0000
Message-Id: <1037298675.16000.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-14 at 17:51, David Mosberger-Tang wrote:
> One potential downside of this is that programmers might expect
> mremap(), mprotect() etc. to work on the returned memory at the
> granularity of base-pages.  I'm not sure though whether that was part
> of the reason Linus wanted separate syscalls.

The extra syscalls dont change anything. mremap/mprotect still fails in
the same way after you use them

