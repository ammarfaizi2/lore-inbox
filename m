Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTGCQGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTGCQF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:05:59 -0400
Received: from granite.he.net ([216.218.226.66]:32011 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264776AbTGCQD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:03:56 -0400
Date: Wed, 2 Jul 2003 16:57:43 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode/dcache overhead of sysfs attribute files?
Message-ID: <20030702235743.GA10868@kroah.com>
References: <20030702215847.GA9973@kroah.com> <3F036F3B.7030004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F036F3B.7030004@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 07:48:11PM -0400, Jeff Garzik wrote:
> Has anybody looked into the inode and dcache overhead of all this stuff, 
> which I assume is pinned into memory a la ramfs?

Yes, there were some numbers in an old thread about 2000 scsi disks.

> I wonder if sysfs attributes could be accessed via the extended 
> attribute VFS API?  A file full of EA's can easily be considered a 
> key-value database, or attribute-value in this case :)  The EA names and 
> values need not pin a bunch of inodes and dcache entries, either.
> (though viro may scream at my mention of EAs :))

Don't know, that could be one way.  I think wli and shaggy were working
on something along these lines, but haven't heard from them in a long
time about it.

thanks,

greg k-h
