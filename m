Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUDTPgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUDTPgT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 11:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUDTPgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 11:36:19 -0400
Received: from colin2.muc.de ([193.149.48.15]:29194 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263117AbUDTPgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 11:36:18 -0400
Date: 20 Apr 2004 17:36:16 +0200
Date: Tue, 20 Apr 2004 17:36:16 +0200
From: Andi Kleen <ak@muc.de>
To: Matthew Wilcox <willy@debian.org>
Cc: Helge Deller <deller@gmx.de>, Andi Kleen <ak@muc.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, joe.korty@ccur.com,
       linux-kernel@vger.kernel.org, "Carlos O'Donell" <carlos@baldric.uwo.ca>
Subject: Re: Fwd: Re: siginfo & 32 bits compat, what is the story ?
Message-ID: <20040420153616.GA60185@colin2.muc.de>
References: <200404200124.50594.deller@gmx.de> <20040420004639.GC18329@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420004639.GC18329@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi, you vetoed the patch.  Don't blame Carlos for it.  That's really
> petty of you.

I requested just one fix for clear brokenness in it, nothing more.

With that change (moving the decision about 32bit vs 64bit thread
into architecture specific code) the patch would be fine for me.
But for some reason Carlos never did that change.

-Andi
