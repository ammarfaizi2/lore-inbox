Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbULaEXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbULaEXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 23:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbULaEXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 23:23:54 -0500
Received: from mail.dif.dk ([193.138.115.101]:58831 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261812AbULaEXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 23:23:48 -0500
Date: Fri, 31 Dec 2004 05:34:58 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: james4765@gmail.com
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk loglevel policy?
In-Reply-To: <41D4D069.3020300@verizon.net>
Message-ID: <Pine.LNX.4.61.0412310532590.26032@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412310259230.4725@dragon.hygekrogen.localhost>
 <2cd57c9004123018203b7e38ef@mail.gmail.com> <41D4D069.3020300@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004, Jim Nelson wrote:

> Coywolf Qi Hunt wrote:
> > Hi all, 
> > Recently, I've seen a lot of add loglevel to printk patches. grep 'printk("'
> > -r | wc shows me 2433. There are probably 2433 printk
> > need to patch, is it?  What's this printk loglevel policy, all these
> > printk calls need loglevel adjusted?  The default loglevel is
> > KERN_WARNING.
> > 
[...]
> 
> The logging levels are, for the most part, common sense.  KERN_ERR for error
> conditions, KERN_INFO for informational (i. e. "driver just loaded", "new disk
> detected"), KERN_CRIT if your computer just caught on fire (!), and KERN_DEBUG
> for any kind of verbose printing.
> 
And the patches I've posted just try to set the loglevel to something 
sensible where what is sensible seems to be obvious. If I'm right or wrong 
I'll leave to the maintainers to decide.


-- 
Jesper Juhl



