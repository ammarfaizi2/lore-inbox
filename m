Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316507AbSEOWaR>; Wed, 15 May 2002 18:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316508AbSEOWaQ>; Wed, 15 May 2002 18:30:16 -0400
Received: from bitmover.com ([192.132.92.2]:21217 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316507AbSEOWaP>;
	Wed, 15 May 2002 18:30:15 -0400
Date: Wed, 15 May 2002 15:30:16 -0700
From: Larry McVoy <lm@bitmover.com>
To: Kenneth Johansson <ken@canit.se>
Cc: David Woodhouse <dwmw2@infradead.org>, Larry McVoy <lm@bitmover.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org
Message-ID: <20020515153016.H13795@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Kenneth Johansson <ken@canit.se>,
	David Woodhouse <dwmw2@infradead.org>,
	Larry McVoy <lm@bitmover.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020515130831.C13795@work.bitmover.com> <20020515122003.A13795@work.bitmover.com> <30386.1021456050@redhat.com> <Pine.LNX.4.44.0205150931500.25038-100000@home.transmeta.com> <20020515122003.A13795@work.bitmover.com> <18732.1021493020@redhat.com> <19065.1021493737@redhat.com> <1021496614.917.33.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also I have found that it is a pain in the a** to have debug code that I
> really don't want to save but it's temporary usefull. When I do a pull

bk park		# saves work as a patch
bk pull
bk unpark	# restores the patch

park/unpark are undocumented because they puke when there are patch rejects.
If we document them, then we have to explain to people what to do when there
are patch rejects, and if you need that explanation, we probably can't help
you.  You guys all grok patch rejects, so try park/unpark.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
