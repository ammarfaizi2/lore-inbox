Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267140AbRGPAWj>; Sun, 15 Jul 2001 20:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266397AbRGPAW3>; Sun, 15 Jul 2001 20:22:29 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:44808 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267140AbRGPAWR>;
	Sun, 15 Jul 2001 20:22:17 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107160022.f6G0MBn310960@saturn.cs.uml.edu>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Sun, 15 Jul 2001 20:22:11 -0400 (EDT)
Cc: reiser@namesys.com (Hans Reiser), alan@lxorguk.ukuu.org.uk (Alan Cox),
        volodya@mindspring.com,
        ajschrotenboer@lycosmail.com (Adam Schrotenboer),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <01071523304400.06482@starship> from "Daniel Phillips" at Jul 15, 2001 11:30:44 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:

> Or we could introduce the notion of logical blocksize for each block
> minor so that we can measure blocks in the same units the filesystem
> uses.  This would give us 16 TB while being able to stay with 32 bits
> everywhere outside the block drivers themselves.
> 
> We are not that far away from being able to handle 8K blocks, so that
> would bump it up to 32 TB.

This is like what the hard drive and BIOS industry has been doing.
First we had the 528 MB limit. Then the 2 GB limit. Then the 4 GB limit.
Then the 8.3 GB limit. Then the 33 GB limit. Then the 127 GB limit.
All along the way, users are cursing the damn limits.

An extra 4 bits buys us 6 years maybe. Nice, except that we
already have people complaining. Maybe somebody remembers when
the complaining started.



