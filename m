Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWACN6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWACN6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWACN6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:58:23 -0500
Received: from ns.suse.de ([195.135.220.2]:43205 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751407AbWACN6W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:58:22 -0500
To: =?iso-8859-1?q?Dieter_St=FCken?= <stueken@conterra.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 + VIA + 4g problems
References: <43B90A04.2090403@conterra.de> <p73k6difvm3.fsf@verdi.suse.de>
	<43BA4C3D.4060206@conterra.de>
From: Andi Kleen <ak@suse.de>
Date: 03 Jan 2006 14:58:21 +0100
In-Reply-To: <43BA4C3D.4060206@conterra.de>
Message-ID: <p731wzpjtvm.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Stüken <stueken@conterra.de> writes:

> Andi Kleen wrote:
> > Can you please post the full boot log? ...
> > When you not compile in the SKGE network driver does everything else work?
> > skge supports 64bit DMA, so it shouldn't use any IOMMU.  But I'm somewhat
> > suspicious of the >4GB support in the VIA chipset. We had problems with
> > that before. It's possible that it's just not supported in the hardware
> > or that the BIOS sets up the MTRRs wrong.
> 
> sorry for the delay, we are a few hors off here...

Does everything work (including the SKGE) driver
when you boot with swiotlb=force ? 

-Andi
