Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266708AbUIISwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266708AbUIISwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUIISst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:48:49 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:1443 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266708AbUIISsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:48:21 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [uml-devel] Re: [patch 1/1] uml:fix ubd deadlock on SMP
Date: Thu, 9 Sep 2004 20:44:54 +0200
User-Agent: KMail/1.6.1
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
References: <20040908172503.384144933@zion.localdomain> <200409092002.19134.blaisorblade_spam@yahoo.it> <20040909113228.M1973@build.pdx.osdl.net>
In-Reply-To: <20040909113228.M1973@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409092044.54512.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 September 2004 20:32, Chris Wright wrote:
> * BlaisorBlade (blaisorblade_spam@yahoo.it) wrote:
> > On Wednesday 08 September 2004 20:12, Chris Wright wrote:
> > > * blaisorblade_spam@yahoo.it (blaisorblade_spam@yahoo.it) wrote:
> > > > Trivial: don't lock the queue spinlock when called from the request
> > > > function. Since the faulty function must use spinlock in another
> > > > case, double-case it. And since we will never use both functions
> > > > together, let no object code be shared between them.
> > >
> > > Why not add a helper which locks around the core function.  Then either
> > > call helper or core function directly depending on locking needs?
> >
> > I'm happy with whatever is nicer.
>
> The way I outlined is nicer as it avoids all that conditional locking.
> I can do a full patch if you like.
Yes, thanks a lot for your help.
Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
