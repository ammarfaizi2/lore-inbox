Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136613AbREANvf>; Tue, 1 May 2001 09:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136614AbREANvS>; Tue, 1 May 2001 09:51:18 -0400
Received: from web5204.mail.yahoo.com ([216.115.106.85]:36112 "HELO
	web5204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S136613AbREANuw>; Tue, 1 May 2001 09:50:52 -0400
Message-ID: <20010501135051.29583.qmail@web5204.mail.yahoo.com>
Date: Tue, 1 May 2001 06:50:51 -0700 (PDT)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: New rtl8139 driver prevents ssh from exiting.
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AEEBAD7.27203DCA@uow.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andrew Morton <andrewm@uow.edu.au> wrote:
> Rob Landley wrote:
> > 
> > The kernel thread the new rtl8139 driver spawns
> > apparently wants to write to stdout, because it
> counts
> > as an unfinished process that prevents an ssh
> session
> > from exiting.
> 
> Does this help?

--- Andrew Morton <andrewm@uow.edu.au> wrote:
> Rob Landley wrote:
> > 
> > The kernel thread the new rtl8139 driver spawns
> > apparently wants to write to stdout, because it
> counts
> > as an unfinished process that prevents an ssh
> session
> > from exiting.
> 
> Does this help?

Assuming this applies cleanly against 2.2.19
(production box; 2.4.3 wasn't ready and 2.4.4 wasn't
available when the first prototypes had to go to
test), I'll let you know in about an hour.

Thanks,

Rob

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
