Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274454AbRITMZw>; Thu, 20 Sep 2001 08:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274451AbRITMZf>; Thu, 20 Sep 2001 08:25:35 -0400
Received: from [24.254.60.16] ([24.254.60.16]:62116 "EHLO
	femail26.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274448AbRITMZa>; Thu, 20 Sep 2001 08:25:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Adrian Cox <adrian@humboldt.co.uk>, tegeran@home.com
Subject: Re: via82cxxx_audio locking problems
Date: Thu, 20 Sep 2001 05:24:38 -0700
X-Mailer: KMail [version 1.2]
Cc: t.sailer@alumni.ethz.ch, Thomas Sailer <sailer@scs.ch>,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BA9AB43.C26366BF@scs.ch> <01092004333500.00182@c779218-a> <3BA9DBED.9020401@humboldt.co.uk>
In-Reply-To: <3BA9DBED.9020401@humboldt.co.uk>
MIME-Version: 1.0
Message-Id: <01092005243800.01369@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 September 2001 05:07 am, Adrian Cox wrote:
> Nicholas Knight wrote:
> > thankyouthankyouthankyouthankyouthankyou
> > Adrian Cox was working on this after I raised the issue on the list,
> > but nobody got anywhere. All we knew was that there were temporary
> > lockups appearing when anything was using the mixer.
>
> This is the right answer. The reason some of us didn't see a problem
> may actually be quite simple: we were using very small buffers in xmms.
> Once I increased the xmms buffer size the problem became visible.

Interesting, I just experimented with it, bringing down the buffers to 
200ms (low as they'll go) and pre-buffer % to 0, does seem to have an 
effect, but it doesn't "fix" the problem for me... Should I just conclude 
that the tolerance for this is higher on some boards/chips than on 
others, and that once THIS problem is fixed, it'll go away and I can 
happily use my volume control again?
