Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288827AbSBDJiK>; Mon, 4 Feb 2002 04:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288821AbSBDJiA>; Mon, 4 Feb 2002 04:38:00 -0500
Received: from [195.157.147.30] ([195.157.147.30]:54285 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S288814AbSBDJhq>; Mon, 4 Feb 2002 04:37:46 -0500
Date: Mon, 4 Feb 2002 09:28:45 +0000
From: Sean Hunter <sean@uncarved.com>
To: Ken Brownfield <brownfld@irridia.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020204092845.A8211@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>,
	Ken Brownfield <brownfld@irridia.com>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <20020201110137.B2560@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201110137.B2560@asooo.flowerfire.com>; from brownfld@irridia.com on Fri, Feb 01, 2002 at 11:01:37AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing I have found useful is to install an old soundcard, and use the
"audio entropy daemon".  This essentially samples static noise in the input
channels of the card, and feeds the result into the kernel entropy pool.

I don't know that anyone maintains this thing any more, so I have begun
rewriting it, in the hope that a maintained version would be more widely
useful.


Sean

On Fri, Feb 01, 2002 at 11:01:37AM -0600, Ken Brownfield wrote:
> On Fri, Feb 01, 2002 at 11:53:20AM -0500, Robert Love wrote:
> | On Fri, 2002-02-01 at 04:17, Ken Brownfield wrote:
> | Most of the useful fixes actually came in a large update from Andreas
> | Dilger.  Perhaps he would have some insight, too.
> 
> Ah, my apoligies then.
> 
> | Exhausting entropy to zero under high use is not uncommon (that is a
> | motivation for my netdev-random patch).  What boggles me is why it does
> | not regenerate?
> 
> Yeah -- slow entropy is "acceptable", but blocking until a reboot is rather unacceptable. ;)
> 
> Thx much,
> -- 
> Ken.
> brownfld@irridia.com
> 
> | 
> | 	Robert
> | 
> | -
> | To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> | the body of a message to majordomo@vger.kernel.org
> | More majordomo info at  http://vger.kernel.org/majordomo-info.html
> | Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
