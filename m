Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUEWP0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUEWP0x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUEWP0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:26:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:15061 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263059AbUEWP0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:26:32 -0400
Date: Sun, 23 May 2004 08:25:40 -0700
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040523152540.GA5518@kroah.com>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085299337.2781.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085299337.2781.5.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 10:02:17AM +0200, Arjan van de Ven wrote:
> On Sun, 2004-05-23 at 08:46, Linus Torvalds wrote:
> > Hola!
> > 
> > This is a request for discussion..
> 
> Can we make this somewhat less cumbersome even by say, allowing
> developers to file a gpg key and sign a certificate saying "all patches
> that I sign with that key are hereby under this regime". I know you hate
> it but the FSF copyright assignment stuff at least has such "do it once
> for forever" mechanism making the pain optionally only once.

I don't think that adding a single line to ever patch description is
really "pain".  Especially compared to the FSF proceedure :)

Also, gpg signed patches are a pain to handle on the maintainer's side
of things, speaking from personal experience.  However our patch
handling scripts could probably just be modified to fix this issue, but
no one's stepped up to do it.  And we'd have to start messing with the
whole "web of trust" thing, which would keep us from being able to
accept a patch from someone in a remote location with no way of being
able to add their key to that web, causing _more_ work to be done to get
a patch into the tree than Linus's proposal entails.

thanks,

greg k-h
