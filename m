Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267754AbUH2Lzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267754AbUH2Lzp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 07:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267758AbUH2Lzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 07:55:45 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:34038 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267754AbUH2Lzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 07:55:43 -0400
Message-ID: <28148.203.122.194.204.1093780542.squirrel@www.csn.ul.ie>
In-Reply-To: <1093779603.2792.19.camel@laptop.fenrus.com>
References: <Pine.LNX.4.58.0408291220330.11976@skynet>
    <1093779603.2792.19.camel@laptop.fenrus.com>
Date: Sun, 29 Aug 2004 12:55:42 +0100 (IST)
Subject: Re: [bk pull] DRM tree - stop i830/i915 in kernel
From: "Dave Airlie" <airlied@linux.ie>
To: arjanv@redhat.com
Cc: "Dave Airlie" <airlied@linux.ie>, torvalds@osdl.org,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> please don't do this.
> This makes it not possible for distributions to ship kernels that need
> to work on both old and new X versions....
>

no, it'll stop distributions from shipping kernels with both drivers
built-in, modular kernels will work fine, X picks the driver to load, if
people are building in the drivers then I believe they know what they are
at...

Having both drivers built-in is obviously broken and actually doesn't work
at all (someone reported it in an Xorg bug...)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@linux.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person

