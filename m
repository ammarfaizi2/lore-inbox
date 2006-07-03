Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWGCVss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWGCVss (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWGCVss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:48:48 -0400
Received: from cantor2.suse.de ([195.135.220.15]:65466 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750944AbWGCVsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:48:47 -0400
Date: Mon, 3 Jul 2006 14:45:09 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Message-ID: <20060703214509.GA5629@kroah.com>
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com> <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com> <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com> <44A95F12.8080208@gmail.com> <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A: No.
Q: Should I include quotations after my reply?

On Mon, Jul 03, 2006 at 04:53:43PM -0400, Daniel Bonekeeper wrote:
> hahahaha I wish I could... well, you are _always_ welcome to donate me
> yours ! =P
> I'll try more later to get one of those readers...
> 
> Reading Greg's comment, now I'm in doubt if this should really be in
> kernel mode or at userspace. Since there is no standard (AFAIK) for
> those readers, how should it be done ?

It all depends on what you want the userspace interface to be.

> Another thing: where can I find documentation about the USB
> architecture ?

www.usb.org for the USB specs.  See the kernel built-in documentation
for a full document on how the Linux USB layer works.

> For example, I suppose that some (or all) USB devices may have DMA
> capabilities... how is this done ?

Heh, no, USB can't do DMA at all.  Why would you think they could?  It's
a serial bus that just streams data across it at relativly slow speeds.

thanks,

greg k-h
