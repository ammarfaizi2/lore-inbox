Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129135AbRBTNda>; Tue, 20 Feb 2001 08:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129294AbRBTNdN>; Tue, 20 Feb 2001 08:33:13 -0500
Received: from kxmail.berlin.de ([195.243.105.30]:53196 "EHLO kxmail.berlin.de")
	by vger.kernel.org with ESMTP id <S129292AbRBTNdG>;
	Tue, 20 Feb 2001 08:33:06 -0500
Message-ID: <3A9271A4.529FF66F@berlin.de>
Date: Tue, 20 Feb 2001 14:31:16 +0100
From: Norbert Roos <n.roos@berlin.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Probs with PCI bus master DMA to user space
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Allocate the buffers in the kernel and mmap() them into user space

But the buffers are usually allocated with malloc() by any application
which wants to use my driver.. otherwise my driver would have to offer a
malloc-like function, but I can hardly force the application to use my
own malloc function.
