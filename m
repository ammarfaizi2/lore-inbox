Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292285AbSBOXmp>; Fri, 15 Feb 2002 18:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292284AbSBOXmZ>; Fri, 15 Feb 2002 18:42:25 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42737
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292283AbSBOXmO>; Fri, 15 Feb 2002 18:42:14 -0500
Date: Fri, 15 Feb 2002 15:42:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: William Lee Irwin III <wli@holomorphy.com>, Robert Love <rml@tech9.net>,
        Robert Jameson <rj@open-net.org>, linux-kernel@vger.kernel.org
Subject: Re: Hard lockup with 2.4.18-pre9 + preempt + lock break + O1k[23] + rmap
Message-ID: <20020215234225.GC5310@matchmail.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Robert Jameson <rj@open-net.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org> <1013780277.950.663.camel@phantasy> <20020215201810.GA5310@matchmail.com> <1013810411.803.1045.camel@phantasy> <20020215232221.GB5310@matchmail.com> <20020215233040.GA782@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020215233040.GA782@holomorphy.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 03:30:40PM -0800, William Lee Irwin III wrote:
> On Fri, Feb 15, 2002 at 03:22:21PM -0800, Mike Fedyk wrote:
> > Yep, I understand.  When I was patching in rmap12f I had to manually
> > merge the little bit into mm/bootmem.c and the offset was several hundred
> > lines.  Then I realized just how much WLI's bootmem patch changes.
> 
> It's a rewrite. Of course it changes the whole file. Lucky for you it
> interacts with nothing else. I seem to remember this conflict being
> somewhat trivial to resolve though.

Yes, it was quite easy to hand merge/fix it up when I added in rmap12f (was
12e... so not much to change.)

Mike
