Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317121AbSFKPR3>; Tue, 11 Jun 2002 11:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317123AbSFKPR2>; Tue, 11 Jun 2002 11:17:28 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:35576 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317121AbSFKPRU>; Tue, 11 Jun 2002 11:17:20 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020611114344.B3081@flint.arm.linux.org.uk> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: Thunder from the hill <thunder@ngforever.de>,
        Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Double quote patches part one: drivers 1/2 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jun 2002 16:16:56 +0100
Message-ID: <5812.1023808616@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
> and then read kernel/fork.s ?  Yes, some people who care about getting
> the best out of the kernel do convert C to assembly and then read the
> result.  If there's something really yucky in there, then you go back
> and fix it in the C source.

s/C/compiler/

Or were you _really_ advocating the kind of development methodology which
gave us all those gotos to out-of-line code which gcc helpfully moved back
in-line for us when it got a little smarter because someone else observed 
the same problem and fixed it _properly_?

Tweaking your code and sacrificing chickens until you happen to get the
output you want is no substitute for fixing the compiler. And it's a waste 
of good chickens.

--
dwmw2


