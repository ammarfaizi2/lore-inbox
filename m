Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269830AbUH0BQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269830AbUH0BQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269930AbUH0BPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:15:48 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:16087 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269902AbUH0BLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 21:11:33 -0400
Date: Fri, 27 Aug 2004 02:11:32 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: maintaining DRM and using bitkeeper..
In-Reply-To: <20040826175937.1da66716.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408270209350.25111@skynet>
References: <Pine.LNX.4.58.0408270043170.25111@skynet>
 <20040826175937.1da66716.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why?

Thanks Dave, that sorts out the I'm stupid and don't know how to use
bitkeeper issue :-), I'm still not in the bk paradigm...

I'll give it a blast this evening...

Dave.

>
> You should always have a current vanilla linus-2.6 BK tree
> locally, and just pull into it occaisionally.  Then when
> you want to do work just clone it using links:
>
> 	bk clone -l linus-2.6 drm-2.6
>
> and fire away. This is the fastest way.
>
> If you're going:
>
> 	bk clone bk://linux.bkbits.net/linux-2.5 drm-2.6
>
> then no wonder it takes all evening :-)
>
> When I rebase I just go:
>
> 	cd linus-2.6
> 	bk pull
> 	cd ..
> 	mv tree treework
> 	bk clone -l linus-2.6 tree
> 	cd tree
> 	bk pull ../treework
>
> and that takes less than 10 minutes even on my super slow
> UltraSPARC machines :-)
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

