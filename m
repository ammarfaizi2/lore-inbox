Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316910AbSE3XBk>; Thu, 30 May 2002 19:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSE3XBj>; Thu, 30 May 2002 19:01:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52984 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316910AbSE3XBi>; Thu, 30 May 2002 19:01:38 -0400
Subject: Re: [PATCH] x86 cpu selection (first hack)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020530225015.GA1829@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 May 2002 01:05:36 +0100
Message-Id: <1022803536.12888.405.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-30 at 23:50, J.A. Magallon wrote:
> - Make all and every cpu a checkbox, so you just say 'I want my kernel to
>   support this and that CPU'. This kills the problem of the ordering, and
>   adds one other advantage: you do not need to support intermediate CPUs,
>   like 'i want my kernel to run ok on pentium-mmx (my firewall) and on
>   p4 (my desktop). I will never run it on a PII, so do not include the
>   hacks for PII'. And of course, 'If I run my p-mmx capable on a friend's
>   PII and it eats his drive and burns his TV set, it is only _my_ fault'.

How about

	'Omit support for processors without an FPU'
	'Omit support for processors without working WP (386, Nexgen)'
	'Require the processor has a TSC'

type questions ?

