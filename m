Return-Path: <linux-kernel-owner+w=401wt.eu-S1751810AbWLNAJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWLNAJF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWLNAJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:09:05 -0500
Received: from cantor2.suse.de ([195.135.220.15]:39609 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbWLNAJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:09:04 -0500
Date: Wed, 13 Dec 2006 16:08:33 -0800
From: Greg KH <gregkh@suse.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: tglx@linutronix.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061214000833.GA9867@suse.de>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <1166044471.11914.195.camel@localhost.localdomain> <Pine.LNX.4.64.0612131323380.5718@woody.osdl.org> <1166048081.11914.208.camel@localhost.localdomain> <1166049055.29505.47.camel@localhost.localdomain> <20061213235601.2a565229@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213235601.2a565229@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 11:56:01PM +0000, Alan wrote:
> On Wed, 13 Dec 2006 23:30:55 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > - IRQ happens
> > - kernel handler runs and masks the chip irq, which removes the IRQ
> > request
> 
> IRQ is shared with the disk driver, box dead. Plus if this is like the
> uio crap in -mm its full of security holes.

All of those security holes should now be taken care of, as all of the
nasty memory stuff has been either cleaned up or ripped out.

Please take a look at the most recent stuff (thomas just mentioned to me
on irc that he has a few more minor fixes for it) and let me know if you
still see any problems.

thanks,

greg k-h
