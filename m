Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbUCKIX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 03:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbUCKIX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 03:23:26 -0500
Received: from [193.108.190.253] ([193.108.190.253]:53405 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S262900AbUCKIXY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 03:23:24 -0500
Subject: Re: UID/GID mapping system
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <04031015412900.03270@tabby>
References: <1078775149.23059.25.camel@luke> <04031009285900.02381@tabby>
	 <1078941525.1343.19.camel@homer>  <04031015412900.03270@tabby>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1078993376.1576.33.camel@quaoar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 09:22:56 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 2004-03-10 kl. 22:41 skrev Jesse Pollard:
> > > > > and unlimited number of groups assigned to a single user?
> > > > No. That's not my problem, is it? I just provide the mapping system.
> > > but the mapping system has to be able to handle it.
> > How do you figure that?
> I should have said "designed to handle it" in a future expansion. I was
> wrong in making 64 bits as important as it looks.

I'm not talking about the 64 bits uid's and gid's. I'm talking about the
mapping system having to handle users' group memberships. Why would it
have to do that?

> > > > The maps are on the client, so that's no issue. The trick is to make it
> > > > totally transparent to the filesystem being mounted, be it networked or
> > > > non-networked.
> > > The server cannot trust the clients to do the right thing.
> > The server can't trust the client as it is now anyway. The client can do
> > whatever it wants already. There is no security impact as I see it.
> Ah - but if the server refuses to map the uid then the server is more
> protected.

Yes. I know. This is not the problem i was trying to fix. This
discussion is going nowhere.
If I redesigned the way house doors worked, you'd be moaning about the
fact that the TV inside the house might be broken or stolen by someone
who enters the house. That's true. It might very well be. The only way
to secure it is to give your key to noone. The second you give you key
to someone else, you're basically fscked. And of course I know this is a
problem. It's a huge problem. I hope someone will fix it some day. It is
not, however, what I'm trying to do here.


-- 
Salu2, Søren.

