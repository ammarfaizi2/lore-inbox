Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVFZVlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVFZVlH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 17:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVFZVje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 17:39:34 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:22410 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261600AbVFZVjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 17:39:25 -0400
Date: Sun, 26 Jun 2005 22:39:21 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, paulus@samba.org,
       eich@pdx.freedesktop.org
Subject: Re: [git patch] DRM 32/64 ioctl patch..
In-Reply-To: <20050626183948.GA21318@infradead.org>
Message-ID: <Pine.LNX.4.58.0506262235400.29729@skynet>
References: <Pine.LNX.4.58.0506261313390.3269@skynet> <20050626183948.GA21318@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I talked to Egbert Eich at Linuxtag and he said he had different compat
> ioctl patch for drm, which actually supports running a 64bit server
> and 32bit clients.
>
> The big question is here, does this patch help to reach this goal or does
> it make that more awkward?

It shouldn't break it, Paulus and Egbert were at least talking about this
stuff, Paulus gave me an easier to integrate patch and worked with me to
get it in shape, my next plan was to start taking pieces of Egberts work
for the other cards and putting it into the kernel...

Egberts work also fixes some problems in userspace but these aren't any
concern of mine really and those fixes need to be put into the Mesa and
X.org trees, it also makes sure backwards compat is better satisfied as
more people will test with a new/old combination..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

