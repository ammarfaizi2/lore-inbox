Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275758AbRJYRXr>; Thu, 25 Oct 2001 13:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275734AbRJYRXh>; Thu, 25 Oct 2001 13:23:37 -0400
Received: from genesis.westend.com ([212.117.67.2]:18655 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP
	id <S275680AbRJYRXU>; Thu, 25 Oct 2001 13:23:20 -0400
Date: Thu, 25 Oct 2001 19:23:51 +0200
From: Christian Hammers <ch@westend.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG() in asm/pci.h:142 with 2.4.13
Message-ID: <20011025192351.A9823@westend.com>
In-Reply-To: <20011025120701.C6557@westend.com> <20011025131107.C4795@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011025131107.C4795@suse.de>; from axboe@suse.de on Thu, Oct 25, 2001 at 01:11:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, Oct 25, 2001 at 01:11:07PM +0200, Jens Axboe wrote:
> > 2.4.13 was the easiest one to reproduce: when starting the tape backup
> > to a HP DDS3/DAT Streamer (C1537A) via a Adaptec SCSI Controller 
> > (Adaptec 7892A in /proc/pci) on a Gigabyte GA-6VTXD Dual Motherboard with
> > two PIII and 2GB of RAM it crashed immediately with the error attached
> > below. The machine was under "stresstest-simulation" load at this time.

> Could you try this patch and see if it fixes the pci.h BUG at least?
This patch did not prevent the crash. Again immediately after rewinding the
tape when it began to write. I'll try now the 2.4.12-ac6... and it works.

> Jens Axboe
bye,

 -christian- (happy about Alan having forked the kernel tree once ago..)

-- 
Christian Hammers    WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
ch@westend.com     Internet & Security for Professionals    Fax 0241/911879
           WESTEND ist CISCO Systems Partner - Premium Certified

