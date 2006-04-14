Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWDNTte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWDNTte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 15:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWDNTte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 15:49:34 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22987 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751433AbWDNTte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 15:49:34 -0400
Date: Fri, 14 Apr 2006 12:48:28 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, sfr@canb.auug.org.au,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Randy Dunlap <rdunlap@xenotime.net>,
       Al Viro <viro@zeniv.linux.org.uk>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [patch 11/22] Fix block device symlink name
Message-ID: <20060414194828.GA4921@kroah.com>
References: <20060413230141.330705000@quad.kroah.org> <20060413230807.GL5613@kroah.com> <20060414005729.GA11766@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060414005729.GA11766@lst.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 02:57:30AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 13, 2006 at 04:08:07PM -0700, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > ------------------
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > 
> > As noted further on the this file, some block devices have a / in their
> > name, so fix the "block:..." symlink name the same as the /sys/block name.
> 
> shouldn't there be a common helper for both the symlink and the
> /sys/block name so erros like this don't happen again?

Yes, there probably should.  If someone wants to create one, I'm sure
that it would be accepted into Linus's tree.

thanks,

greg k-h
