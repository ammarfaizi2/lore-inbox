Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVALVvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVALVvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVALVsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:48:10 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:52449 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261460AbVALVng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:43:36 -0500
Date: Wed, 12 Jan 2005 22:43:26 +0100
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, ak@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] fix: macros to detect existance of unlocked_ioctl and compat_ioctl
Message-ID: <20050112214326.GB14703@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112212954.GA13558@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, we do not do that in the kernel today, and I'm pretty sure we don't

Actually we do. e.g. take a look at skbuff.h HAVE_*
There are other examples too.

> want to start doing it (it would get _huge_ very quickly...)

I disagree since the alternative is so ugly.


> Please don't apply this.  Remember, out-of-the-tree modules are on their
> own.

I don't know who made this "policy", but actively sabotating or denying 
useful facilities to free out of tree modules doesn't seem to be a 
very wise policy to me.

-Andi
