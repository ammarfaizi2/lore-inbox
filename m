Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWCAWQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWCAWQD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWCAWQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:16:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:10172 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751309AbWCAWQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:16:02 -0500
Date: Wed, 1 Mar 2006 14:15:40 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johnrose@austin.ibm.com
Subject: Re: fix build breakage in eeh.c in 2.6.16-rc5-git5
Message-ID: <20060301221540.GA9638@kroah.com>
References: <20060301214600.GA17702@kroah.com> <17414.6192.426294.502401@cargo.ozlabs.ibm.com> <20060301220328.GB7354@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301220328.GB7354@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 02:03:28PM -0800, Greg KH wrote:
> On Thu, Mar 02, 2006 at 08:54:56AM +1100, Paul Mackerras wrote:
> > Greg KH writes:
> > 
> > > This patch should fixe a problem with eeh_add_device_late() not being
> > > defined in the ppc64 build process, causing the build to break.
> > 
> > John Rose just sent a patch making eeh_add_device_late static and
> > moving it to be defined before it is called in
> > arch/powerpc/platforms/pseries/eeh.c.
> > 
> > Since he maintains this stuff, I'm more inclined to take his patch.
> 
> That's fine with me, as long as it makes it into 2.6.16-final :)

Hm, looks like my fix made it into Linus's tree, so you might want to
send him the "correct" way to do this against that.

thanks,

greg k-h
