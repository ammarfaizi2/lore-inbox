Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbQKGLJu>; Tue, 7 Nov 2000 06:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131213AbQKGLJk>; Tue, 7 Nov 2000 06:09:40 -0500
Received: from [62.172.234.2] ([62.172.234.2]:58027 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S130446AbQKGLJc>;
	Tue, 7 Nov 2000 06:09:32 -0500
Date: Tue, 7 Nov 2000 11:09:33 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Michael Vines <mjvines@undergrad.math.uwaterloo.ca>,
        Catalin BOIE <util@deuroconsult.ro>, linux-kernel@vger.kernel.org
Subject: Re: Kernel hook for open
In-Reply-To: <Pine.LNX.4.21.0011071104430.1698-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011071108150.1860-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Tigran Aivazian wrote:
> To test Y2k readiness of programs one simply can use my timetravel kernel
> module. No, doing things in userspace is far more complex and less
> reliable and also simply not good enough (because doesn't cover the case
  ~~~~~~~~

yes, yes, I am aware of the infamous "race in rmmod in blocked syscalls
replaced by a module" problem. But now that y2k is long gone why should I
fix it? :) (it is trivial to fix with MOD_INC/DEC_USE_COUNT anyway).


> of statically-linked binaries):
> 
> http://www.ocston.org/~tigran/tt/tt.html
> 
> Regards,
> Tigran
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
