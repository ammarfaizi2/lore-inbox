Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSKCNY7>; Sun, 3 Nov 2002 08:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSKCNY6>; Sun, 3 Nov 2002 08:24:58 -0500
Received: from holomorphy.com ([66.224.33.161]:60302 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261859AbSKCNY4>;
	Sun, 3 Nov 2002 08:24:56 -0500
Date: Sun, 3 Nov 2002 05:30:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Margit Schubert-While <margit@margit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: U160 on Adaptec 39160
Message-ID: <20021103133014.GJ23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021103124403.00b4c860@mail.dns-host.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021103124403.00b4c860@mail.dns-host.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:59:44PM +0100, Margit Schubert-While wrote:
> Hi,
> 	Anybody know why I'm not getting 160MB transfers ?
> 	Kernel is Suse 2.4.19
> 	MB is Intel D845PESVL + 2.4 P4 + 512MB DDR333 ram.
> 	Adaptec card is in 3rd PCI slot.
> 	AGP ATI 7500 vga
> 	2 x U160 disks on channel B with special U160 cable and actively
> 	terminated.
> 	DVD + DAT on SE channel A. Nothing on U160 channel A.
> 	Snips under from log and /proc
> 	Thanks
> 	Margit Schubert-While

39160 does 80MB/s/channel, the 160MB/s happens pretty much only as
the sum of both channels. I've had one for a couple of years, and it
performs very well, though it won't ever quite live up to the marketing
gimmick for bandwidth on a single channel. ISTR something about RAID
across channels involved, but I just use disks directly instead.


Bill
