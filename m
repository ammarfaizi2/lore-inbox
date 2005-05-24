Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVEXBHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVEXBHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 21:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVEXBEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 21:04:13 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:34318 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261292AbVEXA6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:58:51 -0400
Date: Tue, 24 May 2005 09:06:07 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [VFS-RFC] autofs4 and bind, rbind and move mount requests
In-Reply-To: <E1DaG04-0002hk-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.58.0505240846410.26293@wombat.indigo.net.au>
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
 <E1DaERw-0002cC-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.62.0505232339250.3469@donald.themaw.net>
 <E1DaG04-0002hk-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-102.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2005, Miklos Szeredi wrote:

> > Perhaps not in this case.
> 
> Maybe I'm misunderstanding.
> 
> Are you talking about an automounted filesystem, or the autofs
> filesystem itself.

I'm talking about the autofs filesystem (actually the autofs4 module).

> 
> With the later I can well imagine that you have problems with bind and
> move.

yep.

I'm not really concerned about whether bind and move mounts work or not. I 
just need to establish whether these should be supported and if so, how 
they should work so I can resolve the problem. Personally, I would be 
happy to say these types of mounts are not supported by autofs if I could 
veto the requests.

atm I can easily panic the kernel. As I said, it would be fairly easy to 
fail silently but ....

There's not much in it but see:
http://bugme.osdl.org/show_bug.cgi?id=4589

Sorry that my initial post was unclear and perhaps incomplete but mostly 
people are not that familiar with automounting and often they don't really 
want to know about it. I guess they have their own priorities.

Thanks for your interest.
Ian
