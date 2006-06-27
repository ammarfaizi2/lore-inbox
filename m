Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030748AbWF0IQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030748AbWF0IQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030749AbWF0IQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:16:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:55215 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030748AbWF0IQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:16:03 -0400
Date: Tue, 27 Jun 2006 01:12:52 -0700
From: Greg KH <greg@kroah.com>
To: Jens Axboe <axboe@suse.de>
Cc: Nigel Cunningham <nigel@suspend2.net>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
Message-ID: <20060627081252.GC7181@kroah.com>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271539.29540.nigel@suspend2.net> <20060627070505.GH22071@suse.de> <200606271739.13453.nigel@suspend2.net> <20060627075906.GK22071@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627075906.GK22071@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 09:59:06AM +0200, Jens Axboe wrote:
> Now I haven't followed the suspend2 vs swsusp debate very closely, but
> it seems to me that your biggest problem with getting this merged is
> getting consensus on where exactly this is going. Nobody wants two
> different suspend modules in the kernel. So there are two options -
> suspend2 is deemed the way to go, and it gets merged and replaces
> swsusp. Or the other way around - people like swsusp more, and you are
> doomed to maintain suspend2 outside the tree.

Actually, there's a third option that is looking like the way forward,
doing all of this from userspace and having no suspend-to-disk in the
kernel tree at all.

Pavel and others have a working implementation and are slowly moving
toward adding all of the "bright and shiny" features that is in suspend2
to it (encryption, progress screens, abort by pressing a key, etc.) so
that there is no loss of functionality.

So I don't really see the future of suspend2 because of this...

thanks,

greg k-h
