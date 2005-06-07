Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVFGQV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVFGQV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVFGQVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:21:17 -0400
Received: from [81.2.110.250] ([81.2.110.250]:40370 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261931AbVFGQU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:20:56 -0400
Subject: Re: fdomain SCSI driver broken in 2.6 series?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christian Trefzer <ctrefzer@web.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <429AFA40.3010705@web.de>
References: <429AFA40.3010705@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118161118.26661.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Jun 2005 17:18:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-05-30 at 12:34, Christian Trefzer wrote:
> I am trying to get an ancient ISA adaptor to work, namely a Future 
> Domain 1860 w/ 18C30 Chip, if I recall correctly. The card is detected 
> properly at base 0x140, irq 11, and the scsi_eh_0 thread is launched as 
> well. But even before the disk is detected, the problem occurs.

I did a bit of cleanup on it during 2.5 to get it to compile and look
right, and it did work for a while when I had the card, but the scsi
changed a lot after that. You are the first fdomain user I've seen in
years so I suspect you are on your own for fixing it too tho I can try
and help a bit.

