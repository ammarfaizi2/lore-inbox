Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbRDYNVB>; Wed, 25 Apr 2001 09:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbRDYNUu>; Wed, 25 Apr 2001 09:20:50 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:11783 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130317AbRDYNUi>;
	Wed, 25 Apr 2001 09:20:38 -0400
Date: Wed, 25 Apr 2001 15:20:30 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@cambridge.redhat.com>, dhowells@redhat.com,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [andrea@suse.de: Re: generic rwsem [Re: Alpha "process table hang"]]
Message-ID: <20010425152029.C18214@pcep-jamie.cern.ch>
In-Reply-To: <24526.987755027@warthog.cambridge.redhat.com> <Pine.LNX.4.31.0104201037580.5523-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104201037580.5523-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Apr 20, 2001 at 10:46:01AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> For i386 and i486, there is no reason to try to maintain a complex fast
> case. The machines are unquestionably going away - we should strive to not
> burden them unnecessarily, but we should _not_ try to save two cycles.
...
> Icache is also precious on the 386, which has no L2 in 99% of all cases.
> Make it out-of-line.

AFAIK, only some 386 clones have a cache -- the Intel ones do not.
Therefore saving icache is not an issue, and the cycle cost of an out of
line call is somewhat more than two cycles.

-- Jamie
