Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313512AbSDLK40>; Fri, 12 Apr 2002 06:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313515AbSDLK4Z>; Fri, 12 Apr 2002 06:56:25 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:43183 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S313512AbSDLK4Z>; Fri, 12 Apr 2002 06:56:25 -0400
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 12 Apr 2002 12:56:05 +0200
MIME-Version: 1.0
Subject: Re: Using video memory as system memory
Message-ID: <3CB6D965.27604.10B6CD3@localhost>
In-Reply-To: <20020411142303.GA120@elf.ucw.cz>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   How fast can one drive a pci card video memory? I once came up with the 
idea to use the video memory of a pci video card as a block device and use it to 
put the journal from ext3. Of course it wouldn't be solid state like the cards in the 
market, at least without a battery and some circuitry changes, and i dismissed 
the idea as the result of too much caffeine in my blood.



/Pedro

On 11 Apr 2002 at 16:23, Pavel Machek wrote:

> Hi!
> 
> > Does the kernel support noncontiguous main memory like this, or is
> > it just plain impossible to use PCI-mapped memory as main memory?
> 
> It might be possible (don't know why it does not work for you), but
> bear in mind that PCI is *very* slow compared to your main memory.
> 
> [Oh, you might want to add that memory late in boot phase. At begining
> of kernel boot, that area is probably not mapped, yet. PCI is
> initialized later.]
>          Pavel
> -- 

