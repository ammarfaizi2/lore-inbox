Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270752AbUJURx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270752AbUJURx0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270780AbUJURxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:53:01 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:6409 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270759AbUJURvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:51:44 -0400
Message-ID: <4177F9F1.2010404@techsource.com>
Date: Thu, 21 Oct 2004 14:03:29 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com>	 <1098313825.12374.74.camel@localhost.localdomain>	 <4177D163.2000503@techsource.com> <9e473391041021082571fa9440@mail.gmail.com>
In-Reply-To: <9e473391041021082571fa9440@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jon Smirl wrote:
> An experimental feature I've heard being proposed is to generate font
> bitmaps dynamically on the card. The idea is to load the TrueType
> glyphs onto the card and then generate a temp bitmap when you know
> exactly the size/subpixel alignment that you need. Implementing this
> probably means you need 3D FP transform units. This is just an
> experiment proposal, no one has built it yet so no one knows if it is
> going to work very well. It might be an opportunity to try for some
> patents.
> 


I would expect glyphs to be rendered into bitmaps on-demand and cached.
I would expect the cache to have such a HIGH hit rate that it's not 
worth dedicating hardware to the relatively infrequent event of 
rasterizing a glyph.

Now, providing the means to efficiently use those cached bitmaps, on the 
other hand, is definately worth the effort.

