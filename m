Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268000AbRHATYc>; Wed, 1 Aug 2001 15:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267996AbRHATYW>; Wed, 1 Aug 2001 15:24:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40198 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267997AbRHATYI>;
	Wed, 1 Aug 2001 15:24:08 -0400
Date: Wed, 1 Aug 2001 20:24:09 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jussi Laako <jlaako@pp.htv.fi>
Cc: Per Jessen <per.jessen@enidan.com>, linux-kernel@vger.kernel.org,
        linux-laptop@vger.kernel.org
Subject: Re: PCMCIA control I82365 stops working with 2.4.4
Message-ID: <20010801202409.A27667@flint.arm.linux.org.uk>
In-Reply-To: <3B5D8A0A002D181A@mta2n.bluewin.ch> <20010801114105.A26615@flint.arm.linux.org.uk> <3B68557B.7816FE4B@pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B68557B.7816FE4B@pp.htv.fi>; from jlaako@pp.htv.fi on Wed, Aug 01, 2001 at 10:16:11PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2001 at 10:16:11PM +0300, Jussi Laako wrote:
> Kills (deadlocks) my Toshiba Satellite when loaded as module (complains
> about missing interrupts). When built into kernel it just complains but
> doesn't lockup the machine.
> 
> Older kernels/pcmcia-cs i82365 was working fine. (2.2.x and early 2.4.x)

Hmm, I'm not an x86 expert, so I'll have to leave you here.  What I do know
is that yenta is for PCI-based PCMCIA controllers with CardBus support.
i82365 is for ISA PCMCIA controllers only.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

