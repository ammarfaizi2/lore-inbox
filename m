Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268033AbUIPMhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268033AbUIPMhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUIPMfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:35:25 -0400
Received: from colin2.muc.de ([193.149.48.15]:65293 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268013AbUIPMeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:34:19 -0400
Date: 16 Sep 2004 14:34:17 +0200
Date: Thu, 16 Sep 2004 14:34:17 +0200
From: Andi Kleen <ak@muc.de>
To: Sergei Haller <Sergei.Haller@math.uni-giessen.de>, g@muc.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
Message-ID: <20040916123417.GA68423@muc.de>
References: <2EWxl-7CI-13@gated-at.bofh.it> <m3hdpyy9x3.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0409162209450.26494@fb07-calculator.math.uni-giessen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409162209450.26494@fb07-calculator.math.uni-giessen.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 10:15:22PM +1000, Sergei Haller wrote:
> I am sure you did read the rest of my mail, didn't you? I mean the part 

I did.

> where I describe that there is an option in the BIOS for that but the 
> kernel crashes if I enable it.

It means the memory was not correct configured. If you don't trust the kernel
you can use memtest86 to confirm it.

> If it is still a problem of the BIOS, could you please be more specific 
> about what exactly is the problem with the BIOS?

That it doesn't supply usable memory to the kernel with that option.

-Andi
