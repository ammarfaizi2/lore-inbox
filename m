Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVDASab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVDASab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVDAS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:29:23 -0500
Received: from smtpout16.mailhost.ntl.com ([212.250.162.16]:64880 "EHLO
	mta08-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S262847AbVDAS1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:27:38 -0500
Message-ID: <424D929A.2030801@gentoo.org>
Date: Fri, 01 Apr 2005 19:27:38 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David N. Welton" <davidw@dedasys.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, helge.hafting@hist.no,
       opengeometry@yahoo.ca
Subject: Re: rootdelay
References: <87wtrphuvj.fsf@dedasys.com>
In-Reply-To: <87wtrphuvj.fsf@dedasys.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David N. Welton wrote:
> [ Please CC replies to me, thanks! ]
> 
> Hi, I was looking at your patch:
> 
> http://lkml.org/lkml/2005/1/21/132
> 
> Very small, which is nice.
> 
> I was wondering if there were any interest in my own efforts in that
> direction:
> 
> http://dedasys.com/freesoftware/patches/blkdev_wakeup.patch
> 
> which is far more intrusive, and perhaps isn't good kernel programming
> style, but, on the other hand, is the optimal solution in terms of
> boot time because it wakes up the boot process right when the device
> comes on line.
> 
> Since I saw your patch included, it looks like there is interest in
> this, and I'd toot my own horn once more before just leaving my patch
> to the bit rot of the ages...
> 
> Thanks!

As simple as it may be, it's a bit of a shame that we actually need rootdelay 
as its something that the kernel should do automatically. At the time when we 
last discussed it, we didn't come up with a better (and safe) way to handle 
it, but I don't think we considered anything like your implementation.

I've CC'd a few people who were involved the last time around to see if they 
have any input for you.

Daniel
