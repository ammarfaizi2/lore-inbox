Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSLZBgs>; Wed, 25 Dec 2002 20:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSLZBgs>; Wed, 25 Dec 2002 20:36:48 -0500
Received: from havoc.daloft.com ([64.213.145.173]:30670 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261645AbSLZBgr>;
	Wed, 25 Dec 2002 20:36:47 -0500
Date: Wed, 25 Dec 2002 20:44:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Ro0tSiEgE <lkml@ro0tsiege.org>
Cc: linux-kernel@vger.kernel.org, "Peter T. Breuer" <ptb@it.uc3m.es>
Subject: Re: [BUG] 2.4 series: IDE driver
Message-ID: <20021226014457.GA4263@gtf.org>
References: <200212251134.gBPBYxJ29966@oboe.it.uc3m.es> <200212251931.50379.lkml@ro0tsiege.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212251931.50379.lkml@ro0tsiege.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2002 at 07:31:50PM -0600, Ro0tSiEgE wrote:
> I own an HP Pavilion ze4145 notebook, and the ALi5x3 chipset bombs after about 
> 30-40mins of use with "hda: lost interrupt" commands, and this continues 
> until I cut the power, though sometimes after about an hour it will reset and 
> go on, but it is very iffy. I noticed that "32-bit I/O" was disabled by 
> default in the BIOS, however I have enabled it. Is this a problem in the 
> kernels ALi drivers or what? The XP install that came with it works fine. 
> What suggestions to fixing this? Thanks

What kernel version?  I'm sorry if I missed it.

Do you have ACPI enabled?

Try booting with "acpi=off", or with "noapic".

	Jeff



