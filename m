Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVCCIzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVCCIzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 03:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVCCIzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 03:55:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:959 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261654AbVCCIzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 03:55:36 -0500
Date: Thu, 3 Mar 2005 00:53:53 -0800
From: Greg KH <greg@kroah.com>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303085352.GA29955@kroah.com>
References: <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <yq0y8d5dtg9.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0y8d5dtg9.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 03:28:22AM -0500, Jes Sorensen wrote:
> 
> Greg> So, while I like the _idea_ of the 2.6.x.y type releases, having
> Greg> those releases contain anything but a handful of patches will
> Greg> quickly get quite messy.
> 
> Wouldn't this actually happen automatically simply by Linus switching
> to being a lot more picky about whats accepted into an even release. I
> agree that if it becomes too formal it could probably turn into an
> unmaintainable mess. However, by simply making it a golden rule, then
> developers can just continue pushing their patches and the people
> above can just shift things to -mm that aren't deemed suitable for the
> even release.
> 
> I think this would work quite well.

Sure, but the point about people not testing the odd release would still
stand.  As it is today, we've been pretty good about only allowing
bugfixes into the later -rc releases.  But I know I start queuing
"bigger" fixes at that point in time, allowing them to get more testing
in -mm release, and generally trying to be conserative.  

And sometimes, people really want those "big" fixes, and they switch to
using the bk-usb patchset, or the bk-scsi patchset.  That happens a lot
for when distros work to stabilize their release kernels.  But that is
quite different from trying to do that for a 2.6.x.y release.

thanks,

greg k-h
