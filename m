Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVBQXHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVBQXHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVBQXDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:03:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25066 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261226AbVBQXCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:02:15 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Date: Thu, 17 Feb 2005 15:00:58 -0800
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200502151557.06049.jbarnes@sgi.com> <1108680436.5665.9.camel@gaston> <9e47339105021714593115dacf@mail.gmail.com>
In-Reply-To: <9e47339105021714593115dacf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502171500.58602.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 17, 2005 2:59 pm, Jon Smirl wrote:
> On Fri, 18 Feb 2005 09:47:15 +1100, Benjamin Herrenschmidt
>
> <benh@kernel.crashing.org> wrote:
> > We could provide additional helpers, like pci_find_rom_partition(),
> > which takes the architecture code as an argument. It would check the
> > signature, and iterate all "partitions" til it finds the proper
> > architecture (or none).
>
> The spec allows for it but has anyone actually seen a ROM with
> multiple images in it? I haven't but I only work on x86.

I haven't seen any either, but maybe the parisc folks have?

Jesse
