Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbRGMUCh>; Fri, 13 Jul 2001 16:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267537AbRGMUC2>; Fri, 13 Jul 2001 16:02:28 -0400
Received: from sncgw.nai.com ([161.69.248.229]:44492 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267536AbRGMUCQ>;
	Fri, 13 Jul 2001 16:02:16 -0400
Message-ID: <XFMail.20010713130537.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200107131939.f6DJdb921665@eng2.sequent.com>
Date: Fri, 13 Jul 2001 13:05:37 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Gerrit Huizenga <gerrit@us.ibm.com>
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@suse.de>, lse-tech@lists.sourceforge.net,
        Mike Kravetz <mkravetz@sequent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Jul-2001 Gerrit Huizenga wrote:
> In a lot of cases, UP is just a simplified, degenerate case of SMP (which
> is itself often a degenerate case of NUMA).  Wouldn't it make a lot of
> sense to have a single scheduler which 1) was relively simple, 2) was as
> good as the current scheduler (or better) on UP, and 3) scaled well on SMP
> (and
> NUMA)?  I think the current lse scheduler meets all of those goals pretty
> well.

It's the concept of 'good enough' that seems to have different meanings for
different people.
Personally I could even think that the behaviour for the UP case is 'almost'
the same but, as you can see by watching at the lk threads in the last years,
it's pretty hard to try people to agree on the concept of 'good enough'.
Config options will leave the current scheduler for UP ( or even for not heavy
MP ) while will introduce an option to users that will suffer scheduler
problems.


> Config options means the user has to choose, I have too many important
> choices to make already when building a kernel.

Even when I go at the restaurant I've to chose, but I still prefer that instead
of getting the 'menu du jour'.




- Davide

