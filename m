Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVBIAhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVBIAhy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVBIAhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:37:54 -0500
Received: from palrel13.hp.com ([156.153.255.238]:36745 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261722AbVBIAhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:37:47 -0500
Date: Tue, 8 Feb 2005 16:37:46 -0800
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Wireless Extension v17 (resend)
Message-ID: <20050209003746.GB9792@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20050208181637.GB29717@bougret.hpl.hp.com> <20050208180116.GA10695@logos.cnet> <20050208215112.GB3290@bougret.hpl.hp.com> <20050208184145.GD10799@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208184145.GD10799@logos.cnet>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 04:41:46PM -0200, Marcelo Tosatti wrote:
> On Tue, Feb 08, 2005 at 01:51:12PM -0800, Jean Tourrilhes wrote:
> > 
> > 	You are right, it's not critical, and I was already thinking
> > of not pushing WE-18 to you (the WPA update). I'll stop updating 2.4.X
> > with respect to wireless, the patches will be available on my web page
> > for people who needs it. 
> 
> Please dont miss bugfixes for present functionality. Gracias.

	Depend what you call "bugfix". Fortunately, with the long beta
period I do with the WE, bugs are few. There are only two "bugs" in
WE-16 I'm aware off (fixed in WE-17), but I don't think they are worth
fixing.
	The first is the handling of spyoffset which is potentially
unsafe. Unfortunately, the fix involve some API/infrastructure change,
so is not transparent. Fortunately drivers are clever enough to not
trigger this bug.
	The second is a potential leak of kernel data to user space in
private handler handling. Few drivers use that feature, there is no
risk of crash or direct attack, so I would not worry about it.

> Faster, cleaner, way more elegant, handles intense loads more gracefully, 
> handles highmem decently, LSM/SELinux, etc, etc...
> 
> IMO everyone should upgrade whenever appropriate. 

	If people want to use 2.4.X, I won't prevent them...
	Have fun...

	Jean
