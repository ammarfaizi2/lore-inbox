Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSJRCyZ>; Thu, 17 Oct 2002 22:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262850AbSJRCyZ>; Thu, 17 Oct 2002 22:54:25 -0400
Received: from mail.powweb.com ([63.251.213.34]:52703 "EHLO mail.powweb.com")
	by vger.kernel.org with ESMTP id <S262838AbSJRCyY> convert rfc822-to-8bit;
	Thu, 17 Oct 2002 22:54:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Gross <markgross@thegnar.org>
Organization: thegnar
To: Andi Kleen <ak@muc.de>
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Date: Thu, 17 Oct 2002 19:58:23 -0700
User-Agent: KMail/1.4.3
Cc: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>,
       Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       NPT library mailing list <phil-list@redhat.com>
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <200210171835.21647.markgross@thegnar.org> <20021018021242.GA15853@averell>
In-Reply-To: <20021018021242.GA15853@averell>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210171958.23198.markgross@thegnar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 October 2002 07:12 pm, Andi Kleen wrote:
> I want the x86 CPU error code, which often has interesting clues on the
> problem. trapno would be useful too. I suspect other CPUs have similar
> extended state for exceptions.
>
> I usually hack my kernel to printk() it, but having it in the coredump
> would be more general and you can look at it later.
>
> Eventually (in a future kernel) I would love to have the exception
> handler save the last branch debugging registers of the CPU and the let the
> core dumper put that into the dump too.  Then you could easily
> figure out what the program did shortly before the crash.
>
> -Andi

Having the last branch before a crash would be cool.  Its easy to add note 
sections to core files.  If it turns out to be useful I'm sure the GDB folks 
would support it. 

--mgross
