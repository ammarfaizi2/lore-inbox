Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275816AbRJYRrI>; Thu, 25 Oct 2001 13:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275813AbRJYRq6>; Thu, 25 Oct 2001 13:46:58 -0400
Received: from genesis.westend.com ([212.117.67.2]:56288 "EHLO
	genesis.westend.com") by vger.kernel.org with ESMTP
	id <S275778AbRJYRqk>; Thu, 25 Oct 2001 13:46:40 -0400
Date: Thu, 25 Oct 2001 19:47:10 +0200
From: Christian Hammers <ch@westend.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG() in asm/pci.h:142 with 2.4.13
Message-ID: <20011025194710.A12089@westend.com>
In-Reply-To: <20011025120701.C6557@westend.com> <20011025131107.C4795@suse.de> <20011025192351.A9823@westend.com> <20011025193248.J4795@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011025193248.J4795@suse.de>; from axboe@suse.de on Thu, Oct 25, 2001 at 07:32:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, Oct 25, 2001 at 07:32:48PM +0200, Jens Axboe wrote:
> > This patch did not prevent the crash. Again immediately after rewinding the
> > tape when it began to write. I'll try now the 2.4.12-ac6... and it works.
> Ok, someone else is meddling with the scatterlist then. I'll take a 2nd
> look.

The 2.4.12-ac6 crashed, too, when I killed the dd and cpio processes 
with SIGKILL. I got the extra scsi queue debug information on the console
but it was too much to write down. I now have a serial connection to
another computer and did "ln /dev/ttyS1 /dev/console" in the hope to be
able to save you all kernel output.

 -christian-

-- 
Christian Hammers    WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
ch@westend.com     Internet & Security for Professionals    Fax 0241/911879
           WESTEND ist CISCO Systems Partner - Premium Certified

