Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWHAOeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWHAOeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWHAOep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:34:45 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:2508 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932084AbWHAOeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:34:44 -0400
Date: Tue, 1 Aug 2006 18:34:21 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: James Morris <jmorris@namei.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take2 1/4] kevent: core files.
Message-ID: <20060801143421.GA14827@2ka.mipt.ru>
References: <11544248451203@2ka.mipt.ru> <Pine.LNX.4.64.0608010945090.10827@d.namei> <20060801135538.GA356@2ka.mipt.ru> <Pine.LNX.4.64.0608011024380.11168@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608011024380.11168@d.namei>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 01 Aug 2006 18:34:22 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 10:27:36AM -0400, James Morris (jmorris@namei.org) wrote:
> > > > +	u->ready_num = 0;
> > > > +#ifdef CONFIG_KEVENT_USER_STAT
> > > > +	u->wait_num = u->im_num = u->total = 0;
> > > > +#endif
> > > 
> > > Generally, #ifdefs in the body of the kernel code are discouraged.  Can 
> > > you abstract these out as static inlines?
> > 
> > Yes, it is possible.
> > I would ask is it needed at all?
> 
> Yes, please, it is standard kernel development practice.

Will do.
Thanks, James.

> -- 
> James Morris
> <jmorris@namei.org>

-- 
	Evgeniy Polyakov
