Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWDSPp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWDSPp3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWDSPp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:45:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:52128 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750928AbWDSPp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:45:27 -0400
Date: Wed, 19 Apr 2006 08:40:11 -0700
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060419154011.GA26635@kroah.com>
References: <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 10:16:46AM +0200, Jan Engelhardt wrote:
> >> > Seriously that makes a lot of sense.  All other modules people have come up
> >> > with over the last years are irrelevant and/or broken by design.
> >> 
> >> It's been nearly a year since I proposed this, and we've not seen any 
> >> appropriate LSM modules submitted in that time.
> >> 
> >> See
> >> http://thread.gmane.org/gmane.linux.kernel.lsm/1120
> >> http://thread.gmane.org/gmane.linux.kernel.lsm/1088
> >> 
> >> The only reason I can see to not delete it immediately is to give BSD 
> >> secure levels users a heads-up, although I thought it was already slated 
> >> for removal.  BSD secure levels is fundamentally broken and should 
> >> never have gone into mainline.
> >
> >been a very long time and so far, only out-of-tree LSMs are present,
> >with no public statements about getting them submitted into the main
> >kernel tree.  And, I think almost all of the out-of-tree modules already
> >need other kernel patches to get their code working properly, so what's
> >a few more hooks needed...
> >
> >/me pokes the bushes to flush out the people lurking
> >
> 
> Well then, have a look at http://alphagate.hopto.org/multiadm/
> 
> There is a reason to why people [read: I] do not submit out-of-tree (OOT)
> modules; because I think chances are low that they get in. Sad fact about the
> Linux kernel.

Why do you feel this way.  We document how to get patches applied very
well (look in Documentation/SubmittingPatches and Documentation/HOWTO),
and provide good review comments on anything that is posted.

We also have a kernel-mentors mailing list that people use to vet their
patches to get them into shape for submission.

So please feel free to submit your patch, especially as without another
LSM user in the kernel tree, the interface will probably go away.

thanks,

greg k-h
