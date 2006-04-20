Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWDTRH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWDTRH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWDTRH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:07:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:54497 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751168AbWDTRHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:07:07 -0400
Date: Thu, 20 Apr 2006 10:02:41 -0700
From: Tony Jones <tonyj@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Removing EXPORT_SYMBOL(security_ops) (was Re: Time to remove LSM)
Message-ID: <20060420170241.GA30948@suse.de>
References: <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <20060419154011.GA26635@kroah.com> <Pine.LNX.4.64.0604191221100.4408@d.namei> <20060419181015.GC11091@kroah.com> <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil> <20060420150037.GA30353@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420150037.GA30353@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 08:00:37AM -0700, Greg KH wrote:

> Tony, would AppArmor have problems if we don't export that variable
> anymore?

I don't believe so. We are just a user of register_security and we don't
poke around the exported symbol. I guess I'll defer full judgement till I
see the actual patch but based on the 10,000' it seems reasonable to me.

Anyways, it seems like for the immediate you're just looking at tagging
it EXPORT_SYMBOL_GPL which sounds fine too.  I need to make you a t-shirt
with that on it :)

Tony
