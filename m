Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUEWPnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUEWPnO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUEWPnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:43:14 -0400
Received: from mail.kroah.org ([65.200.24.183]:25563 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263089AbUEWPnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:43:12 -0400
Date: Sun, 23 May 2004 08:42:19 -0700
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040523154219.GD5750@kroah.com>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085299337.2781.5.camel@laptop.fenrus.com> <20040523152540.GA5518@kroah.com> <20040523153510.GA24628@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523153510.GA24628@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 05:35:10PM +0200, Arjan van de Ven wrote:
> 
> But I don't buy this. No web of trust is needed if all that is happening is
> filing a form ONCE saying "all patch submissions signed with THIS key are
> automatically certified". That doesn't prevent non-gpg users from using the
> proposed mechanism nor involves web of trust metrics.

Ok, but consider my workload.  I measured one month of patches sent to
me recently and it came out to over 300 unique patches from 86 different
developers (and this is during a stable kernel series...)  Now you put
the burden of work on me to verify that this person who just sent me a
signed patch had already sent me a signed form.  That's a lot of work
for me to do, and will slow me down a lot.

But if I only have to check for that one line added to every patch, no
slow down or extra work needs to be done by me (with the exception that
I also add the "Signed off" tag to the patch with my name, but that's
easily automated by me.)  And in reality, not much extra work for you
either (a simple cut and paste for every patch is pretty simple.)

Oh, and with your system, where would these signed forms be stored at?
That would require infrastructure to be built that we currently do not
have.

thanks,

greg k-h
