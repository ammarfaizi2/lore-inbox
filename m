Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262357AbSJDQTc>; Fri, 4 Oct 2002 12:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbSJDQTc>; Fri, 4 Oct 2002 12:19:32 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:24339 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262357AbSJDQTb>; Fri, 4 Oct 2002 12:19:31 -0400
Date: Fri, 4 Oct 2002 17:24:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [BK PATCH] minor devfs cleanup for 2.5.40
Message-ID: <20021004172457.A3390@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Richard Gooch <rgooch@ras.ucalgary.ca>, Greg KH <greg@kroah.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20021003213908.GB1388@kroah.com> <200210041617.g94GHY008334@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210041617.g94GHY008334@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Fri, Oct 04, 2002 at 10:17:34AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 10:17:34AM -0600, Richard Gooch wrote:
> Greg KH writes:
> > Here's a changeset from Christoph Hellwig that removes some unneeded
> > code from the kernel core.  This was leftover from before devfs became
> > part of the main kernel tree, and was trying to do some naming fixups in
> > kernelspace.  If anyone still has machines using these names, their
> > startup scripts should be modified to use the "standard" devfs names.
> > 
> > Please pull from:  http://linuxusb.bkbits.net/devfs-2.5
> 
> NO! Dammit, you'll break everyone who is using these compact names to
> mount the root FS. Look more closely at the code you're trying to
> remove, and you'll see it's *not* used to avoid work in startup
> scripts. It's only used to create the devfs entry for the root FS.

This is 2.5 and those names were never in mainline.  Use your new
devfs names or plain linux names or just hex numbers.  Linux is
not a place were we keep junk around.

