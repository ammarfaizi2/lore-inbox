Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVCCS1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVCCS1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVCCS0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:26:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:54998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261241AbVCCSZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:25:49 -0500
Date: Thu, 3 Mar 2005 10:27:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <422751C1.7030607@pobox.com>
Message-ID: <Pine.LNX.4.58.0503031022100.25732@ppc970.osdl.org>
References: <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net>
 <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <422751C1.7030607@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Mar 2005, Jeff Garzik wrote:
> 
> The only problem I see with this -- and its a minor problem -- is that 
> some patches that belong in the 2.6.X.Y tree go straight to you/Andrew, 
> rather than to $sucker.

Yes. I think people will have to be taught, and get used to the new world
order, and that could take a long time. And don't get me wrong, I include
myself in those people, ie it's not just that everybody else needs to
learn to Cc: the new group (I assume it's best to have a mailing alias, to
allow the thing to have multiple people involved even before it gets to
the vetting stage, and then have a _separate_ mail alias for the "vettign
group" people).

Think of how the -mm tree has evolved - with me and Andrew learning how 
the other side acts and works. This would be the same thing, except 
hopefully on a smaller scale (ie the _volume_ of patches had better be an 
order of magnited smaller not just in size but in number too). It wasn't 
just "let's set up Andrew". It was a learning experience.

And yes, we'll probably get duplicated changes, _especially_ early on. But 
at least nobody seems to hate this idea, so I think we should drop the 
original even/odd suggestion for now, and see if this would make more 
sense..

		Linus
