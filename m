Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbRBPSJy>; Fri, 16 Feb 2001 13:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129426AbRBPSJp>; Fri, 16 Feb 2001 13:09:45 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:39696 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129189AbRBPSJd>;
	Fri, 16 Feb 2001 13:09:33 -0500
Date: Fri, 16 Feb 2001 19:09:19 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010216190919.A4886@pcep-jamie.cern.ch>
In-Reply-To: <20010216151839.A3989@pcep-jamie.cern.ch> <3A8D4045.F8F27782@colorfullife.com> <20010216162741.A4284@pcep-jamie.cern.ch> <3A8D4D43.CF589FA0@colorfullife.com> <20010216170029.A4450@pcep-jamie.cern.ch> <3A8D540C.92C66398@colorfullife.com> <20010216174316.A4500@pcep-jamie.cern.ch> <3A8D5F6C.D81F2F28@colorfullife.com> <20010216183707.A4821@pcep-jamie.cern.ch> <3A8D6BB1.342E62DB@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8D6BB1.342E62DB@colorfullife.com>; from manfred@colorfullife.com on Fri, Feb 16, 2001 at 07:04:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> A very simple test might be
> 
> cpu 1:
> cpu 2:

Ben's test uses only one CPU.

> Now start with variants:
> change to read only instead of not present
> a and b in the same way of the tlb, in a different way.
> change pte with write, change with lock;
> .
> .
> .
> 
> But you'll never prove that you tested every combination.

Indeed.

-- Jamie
