Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262219AbSIZHKD>; Thu, 26 Sep 2002 03:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262220AbSIZHKD>; Thu, 26 Sep 2002 03:10:03 -0400
Received: from holomorphy.com ([66.224.33.161]:164 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262219AbSIZHKC>;
	Thu, 26 Sep 2002 03:10:02 -0400
Date: Thu, 26 Sep 2002 00:14:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, patman@us.ibm.com,
       andmike@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926071447.GJ3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, patman@us.ibm.com,
	andmike@us.ibm.com
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <20020926064455.GC12862@suse.de> <20020926065951.GD12862@suse.de> <20020926070615.GX22942@holomorphy.com> <3D92B323.4090504@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D92B323.4090504@pobox.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 03:11:31AM -0400, Jeff Garzik wrote:
> I use this driver on my ancient ev56 Alpha, if you need me to do some 
> testing.
> Unfortunately it is fragile and known to have obscure bugs...   Compaq 
> was beating up on this driver for quite a while, but I never saw 
> anything but bandaids [and they fully admitted their fixes were bandaids].
> There is an out-of-tree qlogic driver that is reported to be far better 
> -- but not necessarily close to Linux kernel coding style.
> /me wonders if people are encouraged or scared off, at this point...

I've got no idea what's going on with it. It just happens to explode when
parallel mkfs's are done. It looks like there's a bug where it can walk
off the end of an array when it gets an unexpected message but fixing
that doesn't help.


Thanks,
Bill
