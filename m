Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277115AbRJHUBq>; Mon, 8 Oct 2001 16:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277114AbRJHUBi>; Mon, 8 Oct 2001 16:01:38 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:14289 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S277115AbRJHUBZ>; Mon, 8 Oct 2001 16:01:25 -0400
Date: Mon, 8 Oct 2001 21:01:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ian Thompson <ithompso@stargateip.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can I jump to non-linux address space?
Message-ID: <20011008210153.A12301@flint.arm.linux.org.uk>
In-Reply-To: <20011006085743.A23628@flint.arm.linux.org.uk> <NFBBIBIEHMPDJNKCIKOBGEOPCAAA.ithompso@stargateip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NFBBIBIEHMPDJNKCIKOBGEOPCAAA.ithompso@stargateip.com>; from ithompso@stargateip.com on Mon, Oct 08, 2001 at 10:43:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 10:43:45AM -0700, Ian Thompson wrote:
> Am I correct in assuming that this will not remap the kernel address space?
> If I'm trying to jump from the kernel to this physical address, will I need
> to go through user space first?

If you want to execute code linked at address 0x3000, then you need to
execute it at address 0x3000.

Note that turning off the MMU will effectively change all the memory
mappings.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

