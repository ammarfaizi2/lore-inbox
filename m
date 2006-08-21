Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWHUB7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWHUB7o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 21:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWHUB7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 21:59:44 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:7065 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932114AbWHUB7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 21:59:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OK+Z2SRKwW11kHzK5Dk6pViLXt66Rh8qLp6ACFrDQr4pUew3QEd2l8EdnlhjeF0QV9N9YSI2X0D2aX1iGx6DWZ5DUOr88SQQlHFVN5I4ou4Hpy9TjADH+eNLAy8z4U4xA3GgZow59EfmWdDVFkbJ0qNkq0Jyv3Z12BklpjS1K7Y=
Message-ID: <18d709710608201859o7f1c8075wab0e71cd85814967@mail.gmail.com>
Date: Sun, 20 Aug 2006 22:59:41 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: "Willy Tarreau" <w@1wt.eu>
Subject: Re: [PATCH] loop.c: kernel_thread() retval check
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Solar Designer" <solar@openwall.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060820225823.GD602@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060819234629.GA16814@openwall.com>
	 <1156097717.4051.26.camel@localhost.localdomain>
	 <20060820223442.GA21960@openwall.com>
	 <1156115468.4051.80.camel@localhost.localdomain>
	 <20060820225823.GD602@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/06, Willy Tarreau <w@1wt.eu> wrote:
> That's so true ! We're relying too much on our own time while many people
> might be waiting for some little work to start taking a look at the kernel
> internals !
>
> I think I will be starting to ask for forward porters for the fixed to 2.4
> that need to be ported to 2.6 too.

Well, actually I'd be glad to help. In fact, with this particular 2.4
patch at hand, fixing 2.6 seems incredbly straight-forward (or am I
getting ahead of myself?)
However, I wasn't able to reproduce the bug in my system just by
running losetup under strace. Maybe 2.6.15-1.2054_FC5 has it patched?
If if no one can help me out with this I'll boot into a stock kernel
later and try to trigger the bug again.

Cheers,

    Julio Auto
