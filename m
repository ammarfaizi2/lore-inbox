Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVBQXpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVBQXpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBQXpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:45:41 -0500
Received: from avexch01.qlogic.com ([198.70.193.200]:54161 "EHLO
	avexch01.qlogic.com") by vger.kernel.org with ESMTP id S261240AbVBQXU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:20:27 -0500
Date: Thu, 17 Feb 2005 15:20:47 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Message-ID: <20050217232047.GB15726@plap.qlogic.org>
Mail-Followup-To: Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200502151557.06049.jbarnes@sgi.com> <200502170929.54100.jbarnes@sgi.com> <9e47339105021709321dc72ab2@mail.gmail.com> <200502170945.30536.jbarnes@sgi.com> <1108680436.5665.9.camel@gaston> <9e47339105021714593115dacf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105021714593115dacf@mail.gmail.com>
X-Operating-System: Linux 2.6.8-24.11-default
User-Agent: Mutt/1.5.6i
X-OriginalArrivalTime: 17 Feb 2005 23:20:21.0595 (UTC) FILETIME=[4052B2B0:01C51547]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005, Jon Smirl wrote:
> On Fri, 18 Feb 2005 09:47:15 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > We could provide additional helpers, like pci_find_rom_partition(),
> > which takes the architecture code as an argument. It would check the
> > signature, and iterate all "partitions" til it finds the proper
> > architecture (or none).
> 
> The spec allows for it but has anyone actually seen a ROM with
> multiple images in it? I haven't but I only work on x86.
> 

Yes.  Many SCSI and fibre-channel cards carry multiple images.

--
Andrew Vasquez
