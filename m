Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262217AbSIZHGz>; Thu, 26 Sep 2002 03:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262216AbSIZHGz>; Thu, 26 Sep 2002 03:06:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24082 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262215AbSIZHGy>;
	Thu, 26 Sep 2002 03:06:54 -0400
Message-ID: <3D92B323.4090504@pobox.com>
Date: Thu, 26 Sep 2002 03:11:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, patman@us.ibm.com,
       andmike@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <20020926064455.GC12862@suse.de> <20020926065951.GD12862@suse.de> <20020926070615.GX22942@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> Hmm, qlogicisp.c isn't really usable because the disks are too slow, it
> needs bounce buffering, and nobody will touch the driver (and I don't
> seem to be able to figure out what's going on with it myself), and the
> FC stuff seems to need out-of-tree drivers to work. I wonder if I some
> help converting them to this might be found.


I use this driver on my ancient ev56 Alpha, if you need me to do some 
testing.

Unfortunately it is fragile and known to have obscure bugs...   Compaq 
was beating up on this driver for quite a while, but I never saw 
anything but bandaids [and they fully admitted their fixes were bandaids].

There is an out-of-tree qlogic driver that is reported to be far better 
-- but not necessarily close to Linux kernel coding style.

/me wonders if people are encouraged or scared off, at this point...

