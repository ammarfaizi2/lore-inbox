Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293081AbSBWB64>; Fri, 22 Feb 2002 20:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293083AbSBWB6s>; Fri, 22 Feb 2002 20:58:48 -0500
Received: from bitmover.com ([192.132.92.2]:58005 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293081AbSBWB6j>;
	Fri, 22 Feb 2002 20:58:39 -0500
Date: Fri, 22 Feb 2002 17:58:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Christoph Hellwig <hch@caldera.de>, hpa@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 bitkeeper repository
Message-ID: <20020222175838.G11156@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Christoph Hellwig <hch@caldera.de>, hpa@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020222173222.E11156@work.bitmover.com> <Pine.LNX.4.44.0202221744290.1484-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0202221744290.1484-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Fri, Feb 22, 2002 at 05:46:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 05:46:54PM -0800, Davide Libenzi wrote:
> Larry, i've a question for you.
> Does BK use the same basic algos of diff+patch ?

Absolutely not.

> Or, if CVS fails a merge, what is the probability that BK will succeed on
> the same op ?

About 95% in our source base.  You can actually run a script over the
tree, and retry all the merges with the CVS alg and the BK alg.  The BK
alg automerges about 95% of the ones where CVS would not (could not).

These results are typical, in fact, the percentages go up as the number
of parallel developers go up.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
