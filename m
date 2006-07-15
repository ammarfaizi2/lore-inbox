Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWGOStT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWGOStT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 14:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWGOStT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 14:49:19 -0400
Received: from tomts29-srv.bellnexxia.net ([209.226.175.103]:47554 "EHLO
	tomts29-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751539AbWGOStS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 14:49:18 -0400
Date: Sat, 15 Jul 2006 11:48:10 -0700
From: Greg KH <gregkh@suse.de>
To: Daniel Drake <dsd@gentoo.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, stable@kernel.org,
       Marcel Holtmann <holtmann@redhat.com>
Subject: Re: Linux 2.6.17.5
Message-ID: <20060715184810.GA5240@suse.de>
References: <20060715030047.GC11167@kroah.com> <Pine.LNX.4.64.0607142217020.5623@g5.osdl.org> <44B8A720.3030309@gentoo.org> <44B90DF1.8070400@ns666.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B90DF1.8070400@ns666.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 05:46:57PM +0200, Von Wolher wrote:
> Daniel Drake wrote:
> > Hi Linus,
> > 
> > Linus Torvalds wrote:
> > 
> >> I did a slight modification of the patch I committed initially, in the
> >> face of the report from Marcel that the initial sledge-hammer approach
> >> broke his hald setup.
> >>
> >> See commit 9ee8ab9fbf21e6b87ad227cd46c0a4be41ab749b: "Relax /proc fix
> >> a bit", which should still fix the bug (can somebody verify? I'm 100%
> >> sure, but still..), but is pretty much guaranteed to not have any
> >> secondary side effects.
> >>
> >> It still leaves the whole issue of whether /proc should honor chmod AT
> >> ALL open, and I'd love to close that one, but from a "minimal fix"
> >> standpoint, I think it's a reasonable (and simple) patch.
> >>
> >> Marcel, can you check current git?
> > 
> > 
> > I can confirm that the new fix prevents the exploit from working, with
> > no immediately visible side effects.
> > 
> > Thanks,
> > Daniel
> > 
> 
> Can some one release a 2.6.17.6 ? I think many people are waiting at
> their keyboard to get their systems protected.

If they are waiting, they should use 2.6.17.5, as only Networkmanager is
reported to be having problems with it.

I'll release .6 in a bit, but it will take an hour or so to get it
uploaded and out to the mirrors...

thanks,

greg k-h
