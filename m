Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271049AbRHOF4X>; Wed, 15 Aug 2001 01:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271058AbRHOF4O>; Wed, 15 Aug 2001 01:56:14 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:22145 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S271049AbRHOF4F>;
	Wed, 15 Aug 2001 01:56:05 -0400
Message-ID: <3B7A0F01.DC4CAE4@pobox.com>
Date: Tue, 14 Aug 2001 22:56:17 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dmaynor@iceland.oit.gatech.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <3ce801c12548$b7971750$020a0a0a@totalmef> <200108150532.f7F5WGq01653@penguin.transmeta.com> <20010815014328.A15395@iceland.oit.gatech.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmaynor@iceland.oit.gatech.edu wrote:

> > This is why you mainly find per-process stuff in all the limits.
> >
> > Linux has had (for a while now) a "struct user" that is actually quickly
> > accessible through a direct pointer off every process that is associated
> > with that user, and we could (and _will_) start adding these kinds of
> > limits. However, part of the problem is that because the limits haven't
> > historically existed, there is also no accepted and nice way of setting
> > the limits.
> So when you do impose this, where will it be setable, will there be a flat file in /etc
> like solaris, or compile time for the kernel?

Eh?

Why wouldn't it be like most parameters in Linux,
e.g. dynamically adjustable via a sysctl or /proc?

IMHO, of course...

cu

jjs

