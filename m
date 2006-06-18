Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWFRGuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWFRGuh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 02:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWFRGuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 02:50:37 -0400
Received: from 1wt.eu ([62.212.114.60]:50952 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751108AbWFRGuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 02:50:37 -0400
Date: Sun, 18 Jun 2006 08:48:32 +0200
From: Willy Tarreau <w@1wt.eu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: marcelo@kvack.org, jolivares@gigablast.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4] allow core files bigger than 2GB
Message-ID: <20060618064832.GA31066@1wt.eu>
References: <20060617214507.GA1213@1wt.eu> <1150610993.3117.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150610993.3117.2.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 08:09:53AM +0200, Arjan van de Ven wrote:
> On Sat, 2006-06-17 at 23:45 +0200, Willy Tarreau wrote:
> > Marcelo,
> > 
> > I think I have not sent you this one. It looks valid to me.
> > I can queue it in -upstream if you prefer to pull everything
> > at once.
> 
> 
> Hi,
> 
> This is a rather complex issue, to the point that your patch is not
> sufficient actually. While it will create a core file, it's not really a
> good one, and there are some nasty other issues with it (esp on 64 bit
> systems). The enterprise distro kernels have a more complete patch for
> this (I'm pretty sure both RH and SUSE have fundamentally the same patch
> for this), if you really want this functionality I suggest getting the
> patch from either of those distros to get the full thing (there's some
> security angle to this even iirc).

Thanks for notifying us about this Arjan. I've checked in RHEL patches
and found that this is done in 2.4.21-binfmt-elf.patch with a detailed
explanation. The patch is rather large, not to say invasive. I believe
it serves other purposes but it seems to me that it will still be
invasive enough not to be merged into 2.4 mainline right now.

> Greetings, 
>    Arjan van de Ven

Regards,
Willy

