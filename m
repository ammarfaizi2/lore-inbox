Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTJWIdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 04:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTJWIdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 04:33:06 -0400
Received: from natsmtp01.rzone.de ([81.169.145.166]:28083 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261722AbTJWIdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 04:33:03 -0400
Message-ID: <3F979221.7070409@softhome.net>
Date: Thu, 23 Oct 2003 10:32:33 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Rozhavsky <mike@minantech.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
References: <JB3R.23s.23@gated-at.bofh.it> <JBn4.2xt.19@gated-at.bofh.it> <JBPW.36x.3@gated-at.bofh.it>
In-Reply-To: <JBPW.36x.3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rozhavsky wrote:
>>Considered the time normally spent in the kernel, a few percent faster
>>code there wouldn't be noticeable.
> 
> What about firewall/router applications?
> 

   First. Network stack is already hand-optimized.
   Second. It will not make software firewall/routers running faster - 
especially regarding latencies - bottleneck is elsewhere.

   Just FYI.

P.S. Actually I find Linux kernel being quite good hand optimized 
already. But in any way, life in kernel would be made easier have we 
decent portable compiler. But as to compilers 'decent portable' really 
sounds like 'mission imposible'. And primary goal of gcc sure standard 
conformance and portability - and it does this well. That's actually why
we are using it ;-)

  -- Person using gcc on Linux 2.4 x86/ppc32 & Solaris 8/9 with no 
problems at all.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

