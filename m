Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269415AbUIYVLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269415AbUIYVLi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 17:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269416AbUIYVLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 17:11:38 -0400
Received: from dp.samba.org ([66.70.73.150]:37303 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269415AbUIYVLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 17:11:36 -0400
Date: Sat, 25 Sep 2004 14:10:55 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeremy Allison <jra@samba.org>,
       YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925211055.GC580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <20040925182907.GS580@jeremy1> <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org> <20040925195256.GB580@jeremy1> <Pine.LNX.4.58.0409251317410.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409251317410.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 01:21:29PM -0700, Linus Torvalds wrote:
> 
> I repeat: the Linux client is apparently better off ignoring it totally.
> 
> That makes it meaningless, Jeremy. 

Currently I can't argue with you on that.

> After all, the only thing we can use it for is st_blocks, and since the 
> granularity is _so_ big, we're much better off looking at the file size 
> and guessing from that.
> Tell me again: why should the Linux client look at that number? Give me 
> just _one_ valid reason.

Right now (Samba 3.0.7) you are correct. But the intent is
to fix it going forward, so that in non-broken server implementations
(yes the Samba implementation is broken right now) then it
will be correct (ie. follow the intent of the spec).

Sorry, can't fix the past, I can only fix the future :-).

Jeremy.
