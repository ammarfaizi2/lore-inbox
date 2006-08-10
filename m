Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWHJMVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWHJMVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWHJMVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:21:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:18133 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751465AbWHJMVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:21:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CenZz6CUimBgUsGD8X11crLX2HcoW3uE2L/MGUDLEomVLLtUDLaAbm35+qKIKR0HTf8aZh8JPpS7LWF2qBmkwJNNO98brMYf3Ed88dKr5ZMt/mGzkRz6kqYeFlF9IR+fPr8CUlH4mcFq79Zo5BtkdqOyM/ZolK6WdUfLN+UQs0U=
Message-ID: <62b0912f0608100521g796cc773k2309c7235116fe7f@mail.gmail.com>
Date: Thu, 10 Aug 2006 14:21:00 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: ext3 corruption
In-Reply-To: <Pine.LNX.4.61.0608100730580.3624@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <20060810030602.GA29664@mail>
	 <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
	 <Pine.LNX.4.61.0608100730580.3624@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> What is it that you are attempting to do?

Fix my filesystem.
Prevent this situation from happening for others, if at all possible.

> First you show us some text obtained while attempting
> to run fsck on the loop device,
> claiming that this was obtained from a 1TB file-system that
> was destroyed by Linux. Then you spend several days telling us
> that linux is no good. Enough is enough.

That was never really my point, apologies if it came across that way.

> If you had a 1TB file-system and you knew anything about Unix or
> Linux, it would have been fixed by now

What?  Uh.
Well, whatever.

> -- and BTW, samba can't
> destroy a file-system, no matter how many files were open.

Never claimed that it did.

> The worse possible situation is that files, open for write, may
> not be completely written and this only for files that were
> being created or extended. You still have the original file-data
> and all the rest of the files on your file system.

Well, it doesn't mount, so they're kind of irretrievable right now.

> Another point... ext3 is a journaled file-system. Even when
> forced off by hitting the reset switch, ext3 will quietly
> announce "recovering from journal" and mount just fine.

Obviously that's not true.
