Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263412AbUJ2PrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbUJ2PrT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbUJ2Po6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:44:58 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:4371 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263374AbUJ2Pdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:33:45 -0400
Message-ID: <41826617.2010006@techsource.com>
Date: Fri, 29 Oct 2004 11:47:35 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Daniel Phillips <phillips@istop.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Some discussion points open source friendly graphics [was: HARDWARE:
 Open-Source-Friendly Graphics Cards -- Viable?]
References: <417D21C8.30709@techsource.com> <200410271438.30899.phillips@istop.com>
In-Reply-To: <200410271438.30899.phillips@istop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Phillips wrote:
> On Monday 25 October 2004 11:54, Timothy Miller wrote:
> 
>>The reprogramability of the FPGA has many advantages, but
>>reprogramability is not its primary purpose.
> 
> 
> But it might turn out to be a reason for it turning into a geek trophy, if the 
> price is not enormously higher than closed-spec cards.  You could for 
> example, program real-time sound effects processing into the FPGA and output 
> the samples through a standard sound card.
> 
> The enthusiast market is a big market these days.
> 
> 
>>The picture I have in my head at this time expands on the idea of the
>>setup engine seen in most GPU's.  What I'm thinking is that the setup
>>engine will be general-purpose-ish CPU with special vector and matrix
>>instructions.  This way, the transformation stage will occur in
>>"software" executed by a specialized processor.  Additionally, the
>>lighting phase might be done here as well.
>>
>>The setup engine would produce triangle parameters which are fed to a
>>rasterizer which does Gouraud shading and texture-mapping.  That feeds
>>pixels into something that handles antialiasing and alpha blending, etc.
> 
> 
> I hope you're planning to have a divider available to the rasterizer for 
> perspective interpolation, particularly of textures.


My plans are not quite that specific at this time.  For instance, I'm 
not entirely sure, yet, how perspective correction is done.

