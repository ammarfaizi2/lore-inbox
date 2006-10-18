Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWJRVGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWJRVGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWJRVGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:06:47 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:17419 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S1030281AbWJRVGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:06:46 -0400
Date: Wed, 18 Oct 2006 17:06:43 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, ebiederm@xmission.com
Subject: Re: sysctl
In-Reply-To: <20061018124415.e45ece22.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610181705150.7303@lancer.cnet.absolutedigital.net>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
 <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
 <20061018124415.e45ece22.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Andrew Morton wrote:

> We should have added the sysctl numbers to that warning.
> 
> Lots of things do sysctl(KERN_VERSION), including FC5's date(1).  Andi's
> proposal to put some hard-wired KERN_VERSION emulator in there sounds
> reasonable to me, depending upon how many other things we'll need to
> emulate (which we don't know yet).
> 
> A patch which enhances that printk would be appreciated...

I'll take a stab at doing that this evening if nobody beats me to it.

  - C.

-- 
"There is nothing wrong with your television set. Do not attempt
    to adjust the picture. We are controlling transmission."
                    -- The Outer Limits

