Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVAEPDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVAEPDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVAEPDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:03:19 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:8533 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262457AbVAEPDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:03:15 -0500
Date: Wed, 5 Jan 2005 17:03:10 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com,
       tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Message-ID: <20050105150310.GA19758@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050105144043.GB19434@mellanox.co.il> <20050105144603.GA1419@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105144603.GA1419@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Christoph Hellwig (hch@infradead.org) "Re: [PATCH] deprecate (un)register_ioctl32_conversion":
> On Wed, Jan 05, 2005 at 04:40:43PM +0200, Michael S. Tsirkin wrote:
> > Hello, Andrew, all!
> > 
> > Since in -mm1 we now have a race-free replacement (that being ioctl_compat),
> > here is a patch to deprecate (un)register_ioctl32_conversion.
> 
> Sorry, but this is a lot too early.  Once there's a handfull users left
> in _mainline_ you can start deprecating it (or better remove it completely).

I dont know. So how will people know they are supposed to convert then?

> So far we have a non-final version of the replacement in -mm and no single
> user converted.

Christoph, I know you want to remove the inode parameter :)

Otherwise I think -mm1 has the final version of the replacement.

MST
