Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBTNhu>; Tue, 20 Feb 2001 08:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129299AbRBTNhk>; Tue, 20 Feb 2001 08:37:40 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:6186 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129284AbRBTNhd>; Tue, 20 Feb 2001 08:37:33 -0500
Date: Tue, 20 Feb 2001 07:37:26 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Norbert Roos <n.roos@berlin.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Probs with PCI bus master DMA to user space
In-Reply-To: <3A9271A4.529FF66F@berlin.de>
Message-ID: <Pine.LNX.3.96.1010220073651.23246O-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Norbert Roos wrote:
> > Allocate the buffers in the kernel and mmap() them into user space
> 
> But the buffers are usually allocated with malloc() by any application
> which wants to use my driver.. otherwise my driver would have to offer a
> malloc-like function, but I can hardly force the application to use my
> own malloc function.

If you are writing the driver, sure you can.

	Jeff




