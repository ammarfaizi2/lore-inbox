Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291374AbSBGW2R>; Thu, 7 Feb 2002 17:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291375AbSBGW17>; Thu, 7 Feb 2002 17:27:59 -0500
Received: from air-2.osdl.org ([65.201.151.6]:63669 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S291374AbSBGW1r>;
	Thu, 7 Feb 2002 17:27:47 -0500
Date: Thu, 7 Feb 2002 14:28:22 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Peter Osterlund <petero2@telia.com>
cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4-pre1 (decoded) oops on boot in device_create_file
In-Reply-To: <m2bsf1hqz7.fsf@ppro.localdomain>
Message-ID: <Pine.LNX.4.33.0202071426170.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Feb 2002, Peter Osterlund wrote:

> Alessandro Suardi <alessandro.suardi@oracle.com> writes:
> 
> > Must be my time of the year - first the kmem_cache_create one in
> >  2.5.3-pre[45], now this one (should happen about PCI allocation
> >  of one of the Xircom CardBus resources):
> 
> I had the same problem with 2.5.4-pre2. The patch below makes my
> laptop able to boot again, but I don't know if the patch is correct.

That looks ok, since cardbus behaves internally much like PCI. 

I'll check if there's anything else that needs to happen.

	-pat

Btw, thanks - I missed the original email in the sea of all the rest ;)



