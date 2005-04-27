Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVD0S3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVD0S3o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVD0S2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:28:42 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:42414 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261935AbVD0S0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:26:41 -0400
Date: Wed, 27 Apr 2005 11:26:11 -0700
From: Greg KH <gregkh@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Kai.Makisara@kolumbus.fi,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for SG_IO etc.
Message-ID: <20050427182610.GA4400@suse.de>
References: <20050427171446.GA3195@kroah.com> <20050427171649.GG3195@kroah.com> <1114619928.18809.118.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114619928.18809.118.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 05:38:49PM +0100, Alan Cox wrote:
> On Mer, 2005-04-27 at 18:16, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> 
> This patch is just wrong on so many different levels its hard to know
> where to begin.

But that is what is now in mainline, right?  If so, all of these
questions still pertain to the current tree...

> 1. The auth for arbitary commands is CAP_SYS_RAWIO
> 2. "The SCSI command permissions were discussed widely on the linux
> lists but this did not result in any useful refinement of the
> permissions." - this is false. The process was refined, a table setup
> was added and debugged. Someone even wrote an fs for managing it that is
> not yet merged. Perhaps the patch author would care to re-read the
> archives and submit a new patch if one is even needed
> 3. Pleas explain *what* the specific consistency problems are
> 
> And then please fix the same mess in 12rc.

thanks,

greg k-h
