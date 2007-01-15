Return-Path: <linux-kernel-owner+w=401wt.eu-S932252AbXAOMB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbXAOMB0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbXAOMB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:01:26 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:55745 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252AbXAOMBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:01:25 -0500
Date: Mon, 15 Jan 2007 13:01:24 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: prioritize PCI traffic ?
Message-ID: <20070115120124.GA5045@rhlx01.hs-esslingen.de>
References: <1168859265.15294.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168859265.15294.8.camel@localhost>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 15, 2007 at 12:07:45PM +0100, Soeren Sonnenburg wrote:
> Dear all,
> 
> is it possible to explicitly tell the kernel to prioritize PCI traffic
> for a number of cards in pci slots x,y,z ?
> 
> I am asking as severe ide traffic causes lost frames when watching TV
> using 2 DVB cards + vdr... This is simply due to the fact that the PCI
> bus is saturated...
> 
> So, is any prioritizing of the PCI bus possible ?

You probably need to adjust PCI latency settings via setpci:

http://www-128.ibm.com/developerworks/library/l-hw2.html

Not sure whether this is a LKML related question ;)

Andreas Mohr
