Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVHHXaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVHHXaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVHHXaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:30:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2321 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932359AbVHHXaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:30:00 -0400
Date: Tue, 9 Aug 2005 01:29:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: abonilla@linuxwireless.org, "'Andreas Steinmetz'" <ast@domdv.de>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Denis Vlasenko'" <vda@ilport.com.ua>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Wireless support
Message-ID: <20050808232957.GR4006@stusta.de>
References: <005501c59c4a$f6210800$a20cc60a@amer.sykes.com> <1123528018.15269.44.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123528018.15269.44.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 03:06:58PM -0400, Lee Revell wrote:
> On Mon, 2005-08-08 at 12:56 -0600, Alejandro Bonilla wrote:
> > Again, the point is that ndiswrapper is a great project, but people
> > uses it for the leftovers! We *shouldn't* buy leftovers or from Manuf
> > that don't care about Linux.
> 
> If you are always speccing out new systems then of course, but in the
> real world I have some customers who need to dual boot and ideally it
> would work on their existing hardware.  Linux is a harder sell if people
> need to replace a lot of their gear.

That's the advantage of such drivers.

I see at least two disadvantages:

First, it doesn't encourage hardware manufacturers to support open 
source development.

Linux has only a small market share, but it's slowly growing.

Linux driver support does sometimes influence the decision which 
hardware to buy.

With NdisWrapper, the hardware manufacturer can say:
  "Our hardware is supported through the open source NdisWrapper."

Without NdisWrapper, they will sometimes hear that people did choose to 
buy hardware from a different hardware manufacturer that has a Linux 
driver. This can make the hardware manufacturer more friendly towards 
open source development (e.g. by providing hardware specs).

Secondly, binary-only drivers have an impact on the stability of the 
Linux kernel.

E.g. during the last years the nvidia has produced relatively many 
kernel crashes - and I doubt that binary-only drivers for Windows are 
much better in this respect.

The users only see their kernel crashing blaming the Linux kernel and 
harming the reputation of the stability of Linux.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

