Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUHWJeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUHWJeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 05:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUHWJeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 05:34:13 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:29710 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S267618AbUHWJeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 05:34:12 -0400
Date: Mon, 23 Aug 2004 11:34:07 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alexandre <almeida@urbi.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: wrong IDE disk size
Message-ID: <20040823093407.GA2682@pclin040.win.tue.nl>
References: <008601c488c3$a607dd30$21c3060a@nheotfd7dz4lxz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008601c488c3$a607dd30$21c3060a@nheotfd7dz4lxz>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 12:45:35AM -0300, Alexandre wrote:

> I installed two new SAMSUNG SP1203N (120GB) drives on the same IDE.
> But, from the boot log:
> 
> hdc: attached ide-disk driver.
> hdc: host protected area => 1
> hdc: 234493056 sectors (120060 MB) w/2048KiB Cache, CHS=14596/255/63,
> UDMA(100)
> hdd: attached ide-disk driver.
> hdd: host protected area => 1
> hdd: setmax_ext LBA 234493056, native  66055248
> hdd: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=4111/255/63, UDMA(100)
> 
> So the second one get its capacity limited to ~33GB.
> 
> I'm running kernel 2.4.25. CONFIG_IDEDISK_STROKE is off.

You may have set the jumpers on this second disk to limit capacity.

Correct jumper settings and/or try enabling CONFIG_IDEDISK_STROKE.
