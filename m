Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318787AbSHWMx3>; Fri, 23 Aug 2002 08:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSHWMx3>; Fri, 23 Aug 2002 08:53:29 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:27378 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S318787AbSHWMx2>;
	Fri, 23 Aug 2002 08:53:28 -0400
Date: Fri, 23 Aug 2002 08:57:34 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Tom <tom@lemuria.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_alloc bug
Message-ID: <20020823125734.GA8854@www.kroptech.com>
References: <20020823090527.A7715@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020823090527.A7715@lemuria.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 09:05:27AM +0200, Tom wrote:
> first time reporting a kernel bug, so please tell me if you need any
> other details. I'm following the instructions on kernel.org as closely
> as I can.

Actually, you need to follow them a little closer if you want anyone to
help you. Perhaps you missed this paragraph in REPORTING-BUGS:

     If the failure includes an "OOPS:" type message in your log or on screen
     please read "Documentation/oops-tracing.txt" before posting your bug
     report. This explains what you should do with the "Oops" information to
     make it useful to the recipient.

> (5) Output of oops:
> not sure if this is it, but here is what is displayed on the console:
> kernel BUG at page_alloc.c:91!
> invalid operand: 0000
> CPU: 0
> EIP: 0010:[<c012b96d>] Tainted: P
                                  ^
What proprietary modules did you have loaded when this BUG() was hit? nVidia,
perhaps? Reproduce the problem from a cold boot without ever having loaded the
closed-source module(s). If you can't, go talk to whomever made the module; the
community cannot help you solve a problem when we can't see the code.

--Adam

