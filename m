Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267967AbUHTJCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267967AbUHTJCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 05:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUHTI73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:59:29 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:45442 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267737AbUHTI6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:58:42 -0400
Date: Fri, 20 Aug 2004 04:58:29 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: SMP cpu deep sleep
In-reply-to: <1092989207.18275.14.camel@linux.local>
To: Hans Kristian Rosbach <hk@isphuset.no>
Cc: linux-kernel@vger.kernel.org
Message-id: <200408200458.38591.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <1092989207.18275.14.camel@linux.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 20 August 2004 04:06, Hans Kristian Rosbach wrote:
> While reading through hotplug and speedstep patches
> I came to think of a feature I think might be useful.
>
> In an SMP system there are several cpus, this generates
> extra heat and power consuption even on idle load.
> Is there a way to put all cpus but cpu1 into a kind of
> deep sleep? Cpu1 would have to do all work (including irqs)
> of course.

With Rusty's Hotplug CPU, a userspace script should be able to do this by 
cat'ing 1 or 0 into the appropriate sysfs file.

Jeff.

- -- 
"If I have trouble installing Linux, something is wrong. Very wrong."
  - Linus Torvalds
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBJb08wFP0+seVj/4RAotfAJ9gvudaaAQbYjSiky78rkkRnlZHAACfb8oR
Whj349hrd6ZnUPf27JwjJxY=
=mL1E
-----END PGP SIGNATURE-----
