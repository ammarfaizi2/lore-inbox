Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWGDEB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWGDEB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 00:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGDEB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 00:01:57 -0400
Received: from mail.suse.de ([195.135.220.2]:24999 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751063AbWGDEB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 00:01:56 -0400
Date: Mon, 3 Jul 2006 20:58:22 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
Message-ID: <20060704035822.GA18865@kroah.com>
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com> <9e0cf0bf0607030304n62991dafk19f09e41d69e9ab0@mail.gmail.com> <e1e1d5f40607031104o2b8003c8qfa725ae1d276b27f@mail.gmail.com> <44A95F12.8080208@gmail.com> <e1e1d5f40607031353l48826d5bi51558d9f8e12ba3@mail.gmail.com> <20060703214509.GA5629@kroah.com> <e1e1d5f40607031511l5445f338t449bf8840e8caf80@mail.gmail.com> <20060703222645.GA22855@kroah.com> <e1e1d5f40607032056x700c0333rf39fb43c8d73d117@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f40607032056x700c0333rf39fb43c8d73d117@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 11:56:26PM -0400, Daniel Bonekeeper wrote:
> Maybe this is not a default on the market and is something that is
> coming... but seems that some USB controllers are coming with DMA
> capabilities:
> 
> http://www.usb.org/developers/presentations/pres0501/Augustin_DMA_Implem_Final.ppt
> http://www.semiconductors.philips.com/pip/isp1183.html

I think you are a bit confused.  Of course the USB Host controller
devices support DMA, that's how things are set up and work properly
without using a ton of CPU.  They are usually PCI devices and work quite
well and use DMA.

It's the USB devices themselves that don't and can't do any DMA
themselves.

Hope this helps explain things.

greg k-h
