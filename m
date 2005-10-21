Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVJUAjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVJUAjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 20:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVJUAjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 20:39:54 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:44885 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964824AbVJUAjx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 20:39:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gUCy3jn96U67IRTxN8Z7B4w7067bKJKAUeRulweQ+JF8feF+sMIXzFKM7u4D/y2fMfNQti21QkKThTbu/5MofsMb1Mb0a0oy5Gr3c4Cig3m8svLfoSvVgnuiVgsXUnHve2V+c6i7EaY4ieL0Sl2/gKZLZVW1YQp2W4rLhK/cCe8=
Message-ID: <5bdc1c8b0510201739u6b3a5158x5773b6b418d95e32@mail.gmail.com>
Date: Thu, 20 Oct 2005 17:39:52 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc5-rt1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <200510210033.49652.lkml@oxley.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <200510210033.49652.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/05, Felix Oxley <lkml@oxley.org> wrote:
>
> I have the following build error with make allyesconfig:
>
>  CC      arch/i386/kernel/mca.o
> arch/i386/kernel/mca.c: In function 'mca_timer_ack':
> arch/i386/kernel/mca.c:488: error: 'irq' undeclared (first use in this function)
> arch/i386/kernel/mca.c:488: error: (Each undeclared identifier is reported only once
> arch/i386/kernel/mca.c:488: error: for each function it appears in.)
> make[1]: *** [arch/i386/kernel/mca.o] Error 1
> make: *** [arch/i386/kernel] Error 2
>
>
> regards,
> Felix

2.6.14-rc5-rt1 is up and running for me. No errors or problems in
dmesg. Jack is running at 64/2 (<3mS) with no problems so far.

NOTE: I don't know if it matters but I switched from the generic
64-bit processor to AMD-Opteron/Athlon64 at -rc4-rt11 and am using
that with rc5-rt1.

Cheers,
Mark
