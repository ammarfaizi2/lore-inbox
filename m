Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262524AbSJAXcd>; Tue, 1 Oct 2002 19:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262883AbSJAXcd>; Tue, 1 Oct 2002 19:32:33 -0400
Received: from bitmover.com ([192.132.92.2]:63702 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262524AbSJAXcd>;
	Tue, 1 Oct 2002 19:32:33 -0400
Date: Tue, 1 Oct 2002 16:37:57 -0700
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: mau@oscar.prima.de, linux-kernel@vger.kernel.org
Subject: Re: LMbench results for 2.5.40
Message-ID: <20021001163757.J13270@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"David S. Miller" <davem@redhat.com>, mau@oscar.prima.de,
	linux-kernel@vger.kernel.org
References: <20021001220853.GA20022@oscar.dorf.de> <20021001.161554.66190770.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021001.161554.66190770.davem@redhat.com>; from davem@redhat.com on Tue, Oct 01, 2002 at 04:15:54PM -0700
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Patrick Mau <mau@oscar.prima.de>
>    Date: Wed, 2 Oct 2002 00:08:54 +0200
>    
>    Could someone explain the results I marked with '???' ?
>    The ones under 'Local Communication Bandwidth'.

By the way, the place you will probably see variance in LMbench is in the
context switch benchmarks, it's almost certainly due to randomness in 
cache layout and there isn't a thing we can do about it.  You can run a
zillion runs to get an average but please realize that is an *average*.
The context switch number are accurate, the low ones represent no cache
collisions and the high ones represent lots of cache collisions.

FYI.  I don't like it either.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
