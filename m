Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVBWSS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVBWSS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 13:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVBWSSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 13:18:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:11498 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261516AbVBWSSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 13:18:18 -0500
Date: Wed, 23 Feb 2005 09:53:58 -0800
From: Greg KH <greg@kroah.com>
To: Michal Januszewski <spock@gentoo.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050223175358.GN13081@kroah.com>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050219230326.GB13135@kroah.com> <20050220131505.GC19282@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050220131505.GC19282@spock.one.pl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 02:15:05PM +0100, Michal Januszewski wrote:
> On Sat, Feb 19, 2005 at 03:03:26PM -0800, Greg KH wrote:
> 
> > Pavel, I agree with Michal, take a look at this version of the code
> > instead of the version that you posted.  It's a _whole_ lot more sane,
> > and possibly even mergable.
> > 
> > Michal, any thoughts on submitting it for inclusion?  It seems pretty
> > stable now.
> 
> It is pretty stable indeed, I haven't had any major bug reports for 
> quite some time now. It's probably as ready as it's ever going to be.
> So the question is: what should I do with it? Who do I send it to?

As per Documentation/SubmittingPatches, you take the patch, split it up
into logic parts, and post it here at lkml, with a Signed-off-by: line
and a good ChangeLog description in each email.

We can take it from there...

thanks,

greg k-h
