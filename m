Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbTJFKPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 06:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTJFKPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 06:15:16 -0400
Received: from users.linvision.com ([62.58.92.114]:22499 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261354AbTJFKPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 06:15:14 -0400
Date: Mon, 6 Oct 2003 12:15:07 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Petr Cisar <pc@gts.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with SCSI tape in 2.6.0-test6
Message-ID: <20031006101507.GD10529@bitwizard.nl>
References: <20031006084319.GA7360@big.switch.gts.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006084319.GA7360@big.switch.gts.cz>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 10:43:19AM +0200, Petr Cisar wrote:
> I tried to use Compaq SDT-10000 tape drive with the lastest kernel,
> but I am getting these messages in kernel log:
> 
> st0: Failed to read 10240 byte block with 1024 byte transfer.
> 
> and it results in ENOMEM returned by read(). I haven't tried this
> type of tape under any other kernel version, but according to what I
> found on the net, it should work fine.

Normal behaviour for a tape drive, I get the same in 2.4 kernels. Tape
devices are special in that they are character devices with a certain
blocksize.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
