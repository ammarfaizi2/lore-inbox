Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWHITR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWHITR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWHITR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:17:57 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:20199 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751290AbWHITR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:17:56 -0400
Date: Wed, 9 Aug 2006 23:17:18 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take6 1/3] kevent: Core files.
Message-ID: <20060809191718.GA2102@2ka.mipt.ru>
References: <11551105592821@2ka.mipt.ru> <11551105602734@2ka.mipt.ru> <20060809104738.1498723f@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060809104738.1498723f@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 09 Aug 2006 23:17:19 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 10:47:38AM -0700, Stephen Hemminger (shemminger@osdl.org) wrote:
> > +static inline void kevent_user_stat_increase_total(struct kevent_user *u)
> > +{
> > +	u->total++;
> > +}
> >
> 
> static wrapper_functions_with_execessive_long_names(struct i_really_hate *this)
> {
> 	suck();
> }

Understood...

-- 
	Evgeniy Polyakov
