Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284084AbRLAMBT>; Sat, 1 Dec 2001 07:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281593AbRLAMBJ>; Sat, 1 Dec 2001 07:01:09 -0500
Received: from ns.caldera.de ([212.34.180.1]:38814 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S284076AbRLAMAz>;
	Sat, 1 Dec 2001 07:00:55 -0500
Date: Sat, 1 Dec 2001 13:00:48 +0100
Message-Id: <200112011200.fB1C0m711338@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: jread@semiotek.com (Justin Wells)
Cc: linux-kernel@vger.kernel.org
Subject: Re:  Re: Please tag tested releases of the 2.4.x kernel
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20011201113734.5187E38329@fever.semiotek.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[It would be nice f you could teach your mailer about replies..]

Hi Justin,

In article <20011201113734.5187E38329@fever.semiotek.com> you wrote:
> And the kernels on kernel.org *are* tested, by lots of people, by kernel 
> developers, by lots of ordinary folks even. I bet right after theren's 
> an announce on slashdot you see lots of traffic on the ftp/http sites.

The problem is that there is absoloutly no defined QA-cycle for these
kernels. Please take a look at what distributors (at least most, I know
at least one counter-example):

 o they freeze at one public kernel release
 o they do testing, lots of testing
 o they apply bugfixes for problems found in their debugging
   or coming in new releases _only_.  No new major changes that
   might break things.

That's why new distribution releases tend to come with 'old-looking'
kernels.

With kernel.org release _any_ new release mixes features, rewrites and
bugfixes.  I hope this will change a little for 2.4 now that Marcelo
who does the above cycle for for Conectiva takes over maintainership.
But in can't in whole - noone would really freeze the stable series
as strict as distributors do.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
