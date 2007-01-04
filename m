Return-Path: <linux-kernel-owner+w=401wt.eu-S965054AbXADRbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbXADRbA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbXADRbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:31:00 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:36818 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965043AbXADRa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:30:59 -0500
Date: Thu, 4 Jan 2007 18:30:58 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Brad Campbell <brad@wasp.net.au>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: problem with pata_hpt37x ...
Message-ID: <20070104173058.GA2160@MAIL.13thfloor.at>
Mail-Followup-To: Brad Campbell <brad@wasp.net.au>,
	Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
	linux-ide@vger.kernel.org,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20070102070144.GA11270@MAIL.13thfloor.at> <20070102145855.170c03e2@localhost.localdomain> <459D26D4.3010601@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459D26D4.3010601@wasp.net.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 08:09:56PM +0400, Brad Campbell wrote:
> Alan wrote:
> >On Tue, 2 Jan 2007 08:01:45 +0100
> >Herbert Poetzl <herbert@13thfloor.at> wrote:
> >
> >>if you are interested in investigating this, please
> >>let me know what kind of data you would like to see
> >>and/or what kind of tests would be appreciated.
> >
> >I reviewed the 374 code a bit further to see what might be causing this
> >and found the slave channel end of DMA handling was using the wrong port
> >I think.
> 
> This now passes all my stress tests Alan. No more "Interrupt disabled"
> or dmesg storms. I put the HPT Rocketraid 1540 (HPT374) back in a box
> and connected 4 200GB ata drives to it using SATA-PATA bridgeboards as
> before. It looks to be rock solid now.

sounds great! where can I get that version?
should it be in 2.6.20-rc* or is there a separate
patch available somewhere?

TIA,
Herbert

> Brad
> -- 
> "Human beings, who are almost unique in having the ability
> to learn from the experience of others, are also remarkable
> for their apparent disinclination to do so." -- Douglas Adams
