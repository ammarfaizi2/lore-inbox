Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbTAPQiL>; Thu, 16 Jan 2003 11:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbTAPQiL>; Thu, 16 Jan 2003 11:38:11 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:58005 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267185AbTAPQiK> convert rfc822-to-8bit; Thu, 16 Jan 2003 11:38:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
Date: Thu, 16 Jan 2003 17:47:14 +0100
User-Agent: KMail/1.4.3
Cc: Andrew Theurer <habanero@us.ibm.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
References: <52570000.1042156448@flay> <200301151610.43204.efocht@ess.nec.de> <23340000.1042697129@titus>
In-Reply-To: <23340000.1042697129@titus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301161747.14863.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin and Michael,

thanks for testing again!

On Thursday 16 January 2003 07:05, Martin J. Bligh wrote:
> I'm not keen on the way the minisched patch got reformatted. I changed
> it into a seperate function, which I think is much cleaner by the time
> you've added the third patch - no #ifdef CONFIG_NUMA in load_balance.

Fine. This form is also nearer to the codingstyle rule: "functions
should do only one thing" (I'm reading those more carefully now ;-)

> Anyway, I perf tested this, and it comes out more or less the same as
> the tuned version I was poking at last night (ie best of the bunch).
> Looks pretty good to me.

Great!

> PS. The fourth patch was so small, and touching the same stuff as 3
> that I rolled it into the third one here. Seems like a universal
> benefit ;-)

Yes, it's a much smaller step than patch #5. It would make sense to
have this included right from the start.

Regards,
Erich

