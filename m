Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272356AbRHYAV4>; Fri, 24 Aug 2001 20:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272355AbRHYAVq>; Fri, 24 Aug 2001 20:21:46 -0400
Received: from web10906.mail.yahoo.com ([216.136.131.42]:43026 "HELO
	web10906.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272356AbRHYAV3>; Fri, 24 Aug 2001 20:21:29 -0400
Message-ID: <20010825002145.15725.qmail@web10906.mail.yahoo.com>
Date: Fri, 24 Aug 2001 17:21:45 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: Tobias Diedrich <ranma@gmx.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010825021651.I8296@router.ranmachan.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Tobias Diedrich <ranma@gmx.at> wrote:
> Brad Chapman wrote:
> 
> > 	This way, some hackers can use the two-arg min()/max() inside an #ifdef block,
> > other hackers can use the three-arg min()/max() inside an #ifdef block, 
> > and people who don't care can select either.
> 
> Umm, you know this means some drivers will work only with one setting, unless
> you always code both versions, which would be stupid ? 
> 
> -- 
> Tobias						   PGP-Key: 0x9AC7E0BC

Mr. Diedrich,

	Yes, I'm aware of that. That's why we should try to centralize the #ifdef
somewhere, so that everybody sees a unified interface, but at the same time, 
do this correctly _and_ _without_ the use of typeof().

	BTW what is your opinion on the things I suggested?

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
