Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272019AbRHXPA2>; Fri, 24 Aug 2001 11:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272070AbRHXPAS>; Fri, 24 Aug 2001 11:00:18 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:41343
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S272019AbRHXPAM>; Fri, 24 Aug 2001 11:00:12 -0400
Message-ID: <3B866C04.9090903@fugmann.dhs.org>
Date: Fri, 24 Aug 2001 17:00:20 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] const initdata.
In-Reply-To: <Pine.LNX.4.31.0108240051360.1732-100000@noodles.codemonkey.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How "bad" is it to have __initdata declared static?

A quick scan through the kernel tree shows
that 27 .h and 355 .c files needa patching.
(a total of 845 places)

Numbers are from 2.4.9 kernel.

It should be very easy to correct through a script.

Regards
Anders Fugmann


Dave Jones wrote:
> As defined in in Rusty's kernel-hacking doc, __initdata must not be
> marked as const.  Patch below does this for the PCI subsystem.
> 
> *nb*, This kind of patch needs to be done in quite a few other
> places too.
> 
> regards,
> 
> Dave.
> 
> 


