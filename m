Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUKOK1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUKOK1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 05:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUKOK1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 05:27:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19219 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261568AbUKOK0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 05:26:24 -0500
Date: Mon, 15 Nov 2004 10:26:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-rc2
Message-ID: <20041115102620.A25762@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>; from torvalds@osdl.org on Sun, Nov 14, 2004 at 06:49:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 06:49:04PM -0800, Linus Torvalds wrote:
> Ok, the -rc2 changes are almost as big as the -rc1 changes, and we should 
> now calm down, so I do not want to see anything but bug-fixes until 2.6.10 
> is released. Otherwise we'll never get there.

There's a few more non-bugfix changes which need merging first though.
Namely an update to the S3C2410 serial driver from Ben to allow the
s3c2410 changes which are now in 2.6.10-rc2 to work.  Otherwise I
suspect s3c2410 is going to be dead in the water for 2.6.10.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
