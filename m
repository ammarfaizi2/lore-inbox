Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbREYSrE>; Fri, 25 May 2001 14:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbREYSqy>; Fri, 25 May 2001 14:46:54 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:26636 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S261616AbREYSqj>; Fri, 25 May 2001 14:46:39 -0400
Date: Fri, 25 May 2001 11:46:38 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8 
In-Reply-To: <1917.990805795@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.33.0105251145530.17081-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Keith Owens wrote:

> On Fri, 25 May 2001 08:31:24 -0700 (PDT),
> dean gaudet <dean-list-linux-kernel@arctic.org> wrote:
> >another possibility for a debugging mode for the kernel would be to hack
> >gcc to emit something like the following in the prologue of every function
> >(after the frame is allocated):
>
> IKD already does that, via the CONFIG_DEBUG_KSTACK, CONFIG_KSTACK_METER
> and CONFIG_KSTACK_THRESHOLD options.  No need to hack gcc.

oh nice!  you hook in through gcc -pg mcount stuff.

-dean

