Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287631AbSAMSVr>; Sun, 13 Jan 2002 13:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287417AbSAMSVe>; Sun, 13 Jan 2002 13:21:34 -0500
Received: from ns.ithnet.com ([217.64.64.10]:40710 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287421AbSAMSVQ>;
	Sun, 13 Jan 2002 13:21:16 -0500
Date: Sun, 13 Jan 2002 19:20:59 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, anton@samba.org
Subject: Re: [patch] O(1) scheduler, -H7
Message-Id: <20020113192059.68f9bf53.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0201132056360.8784-100000@localhost.localdomain>
In-Reply-To: <20020113185732.72ea3aa8.skraw@ithnet.com>
	<Pine.LNX.4.33.0201132056360.8784-100000@localhost.localdomain>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002 20:58:12 +0100 (CET)
Ingo Molnar <mingo@elte.hu> wrote:

> 
> On Sun, 13 Jan 2002, Stephan von Krawczynski wrote:
> 
> > sched.o sched.c sched.c:21: asm/sched.h: No such file or directory
> 
> Please re-download the 2.4.17 -H7 patch, i've fixed this.

Hello Ingo,

did it. Applied. Compiled ok.

BUT:
I tried it on top of 2.4.18-pre3, it applied clean with some offsets. Only my
machine hangs during boot on first network packets (simple pings). This is
reproducable.

I am retrying with plain 2.4.17 + H7 and be back in few minutes...

Regards,
Stephan


