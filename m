Return-Path: <linux-kernel-owner+w=401wt.eu-S932379AbXARQUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbXARQUT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 11:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbXARQUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 11:20:19 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:60053 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379AbXARQUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 11:20:18 -0500
X-Originating-Ip: 74.109.98.130
Date: Thu, 18 Jan 2007 11:14:12 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Ralf Baechle <ralf@linux-mips.org>
cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org, akpm@osdl.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
In-Reply-To: <20070118160338.GA6343@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0701181112410.21156@CPE00045a9c397f-CM001225dbafb6>
References: <20070119.002346.74752797.anemo@mba.ocn.ne.jp>
 <20070118160338.GA6343@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Ralf Baechle wrote:

> On Fri, Jan 19, 2007 at 12:23:46AM +0900, Atsushi Nemoto wrote:
>
> > CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
> > might result in allocation failure for the reserving itself on some
> > platforms (for example typical 32bit MIPS).  Make it (and
> > CARDBUS_IO_SIZE too) customizable for such platforms.
>
> Patch looks technically ok to me, so feel free to add my Acked-by:
> line.
>
> The grief I have with this sort of patch is that this kind of
> detailed technical knowledge should not be required by a mortal
> configuring the Linux kernel.

that's why help info for options like that should always have a "If
you're unsure about what to say here ..." paragraph.

i'm big on stuff like that.  :-)

rday
