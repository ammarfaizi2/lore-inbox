Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSKRSEf>; Mon, 18 Nov 2002 13:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSKRSEf>; Mon, 18 Nov 2002 13:04:35 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:21514 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262457AbSKRSEe>; Mon, 18 Nov 2002 13:04:34 -0500
Date: Mon, 18 Nov 2002 18:11:34 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] is framebuffer console code in 2.5.4x functional ?
In-Reply-To: <20021118125413.GA312@pazke.ipt>
Message-ID: <Pine.LNX.4.44.0211181808310.22101-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Framebuffer driver sets needed video mode (checked with monitor's ods)
> and starts display dma engine successfuly (i can even draw lines on the
> screen using memset()'s). 

So the driver is functional. I assume also a cat /dev/urandom > /dev/fb 
works as well. 

> But the beautifull linux logo doesn't apear and

Fixed in the fbdev BK tree.

> console doesn't show a single pixel.

:-( Can you post your .config file. 

> Simple(silly) questions:
> 	- is 2.5.4x framebuffer console code really functional ?

If the driver has been ported to the new api then yes it works. I did port 
the SGIVW driver some time ago bit didn't have the hardware to test it. 
I will be posting a new fbdev patch today against 2.5.48 today. Giev it a 
try.



