Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbREVPAX>; Tue, 22 May 2001 11:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbREVPAD>; Tue, 22 May 2001 11:00:03 -0400
Received: from web13408.mail.yahoo.com ([216.136.175.66]:7945 "HELO
	web13408.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261837AbREVO76>; Tue, 22 May 2001 10:59:58 -0400
Message-ID: <20010522145953.32483.qmail@web13408.mail.yahoo.com>
Date: Tue, 22 May 2001 07:59:53 -0700 (PDT)
From: Tommy Hallgren <thallgren@yahoo.com>
Subject: Re: [PATCH] struct char_device
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10105221050080.8984-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I thought about it again, and you are right. Sorry for the noise.

Regards, Tommy

--- Mark Hahn <hahn@coffee.psychology.mcmaster.ca> wrote:
> > + if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) == 
> > + SLAB_CTOR_CONSTRUCTOR) 
> ...
> > + if ((flags & SLAB_CTOR_CONSTRUCTOR) == SLAB_CTOR_CONSTRUCTOR) 
> 
> consider whether flags contains SLAB_CTOR_VERIFY.  in the first case,
> it must be zero.  in the second case, it's ignored.
> 


__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
