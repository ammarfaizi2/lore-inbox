Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265467AbRGPRuR>; Mon, 16 Jul 2001 13:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266715AbRGPRuI>; Mon, 16 Jul 2001 13:50:08 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19729 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265467AbRGPRtw>; Mon, 16 Jul 2001 13:49:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jussi Laako <jlaako@pp.htv.fi>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
Date: Mon, 16 Jul 2001 19:53:59 +0200
X-Mailer: KMail [version 1.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E15LopT-0004Cm-00@the-village.bc.nu> <01071523304400.06482@starship> <3B53221B.28B8D5A1@pp.htv.fi>
In-Reply-To: <3B53221B.28B8D5A1@pp.htv.fi>
MIME-Version: 1.0
Message-Id: <0107161953590C.06482@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 July 2001 19:19, Jussi Laako wrote:
> Daniel Phillips wrote:
> > We are not that far away from being able to handle 8K blocks, so
> > that would bump it up to 32 TB.
>
> That's way too small. Something like 32 PB would be better... ;)

Are you serious?  What kind of application are you running?

> We need at least one extra bit in volume/file size every year.

OK, well hmm, then in 1969 we needed a volume size of 4K.  Um, it's 
probably more accurate to use 18 months as the doubling period.

Anyway, that's what the 64 bit option for buffer_head->b_blocknr is 
supposed to handle.  The question is, is it necessary to go to a 
uniform 64 bit quantity for all users regardless of whether they feel 
restricted by a 32 TB volume size limit or not.

/me figures it will be 9 years before he even has a 1 TB disk in his 
laptop

OK, I looked again and saw the smiley.  Sometimes it's hard to tell 
what's outrageous when talking about disk sizes.

--
Daniel
