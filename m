Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313116AbSDOIwH>; Mon, 15 Apr 2002 04:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313117AbSDOIwH>; Mon, 15 Apr 2002 04:52:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22282 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313116AbSDOIwG>;
	Mon, 15 Apr 2002 04:52:06 -0400
Date: Mon, 15 Apr 2002 10:51:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 34
Message-ID: <20020415085145.GF12608@suse.de>
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com> <3CBA8476.9070208@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Martin Dalecki wrote:

Two comments --

Could you please _not_ just rearrange comments or change style in ide-cd
just for the sake cleaning, it's very annoying when one has patches that
need to be adapted every time. And it serves zero purpose. Thanks.

I changed the CONFIG_BLK_DEV_IDEPCI stuff to always include the pci_dev
in the hwgroup, and just leave it at NULL if not defined. This cleans up
some ifdefs, I think this is the better approach.

I'll sync the latest tcq stuff with you later today, it gets the
enabling right etc.

And a last comment not directly related to this particular patch -- when
you include something and change minor stuff along the way, please do it
in two steps. One that includes a patch, and a second version that
changes what you want to change. That makes merging _so_ much easier.
Thanks.

-- 
Jens Axboe

