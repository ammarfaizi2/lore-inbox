Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSDFRat>; Sat, 6 Apr 2002 12:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312634AbSDFRas>; Sat, 6 Apr 2002 12:30:48 -0500
Received: from bitmover.com ([192.132.92.2]:13524 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S312619AbSDFRas>;
	Sat, 6 Apr 2002 12:30:48 -0500
Date: Sat, 6 Apr 2002 09:30:46 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Larry McVoy <lm@bitmover.com>, Dave Jones <davej@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1
Message-ID: <20020406093046.F6087@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Larry McVoy <lm@bitmover.com>, Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020406090540.B12017@work.bitmover.com> <20020404223425.K11833@suse.de> <20020403195445.U17549@work.bitmover.com> <Pine.LNX.4.33.0204041203440.14206-100000@penguin.transmeta.com> <20020404223425.K11833@suse.de> <22175.1018107407@redhat.com> <20020406090540.B12017@work.bitmover.com> <24920.1018113947@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2002 at 06:25:47PM +0100, David Woodhouse wrote:
> c) Observe that all the files touched are identical in the two repositories
> 	before the changeset in question.
>    Copy the post-changeset SCCS files for the changed files to the new 
> 	repository.

bk pull the two repositories together, run bk -r check -ap and watch it 
get unhappy.

Mutter darkly that people really seem to not understand it's a distributed,
replicated system and playing with the datastructures will make it unhappy.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
