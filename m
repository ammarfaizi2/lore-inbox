Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288485AbSANAgl>; Sun, 13 Jan 2002 19:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288449AbSANAfh>; Sun, 13 Jan 2002 19:35:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1549 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288473AbSANAet>; Sun, 13 Jan 2002 19:34:49 -0500
Subject: Re: [PATCH] 1-2-3 GB
To: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 14 Jan 2002 00:46:21 +0000 (GMT)
Cc: mjustice@austin.rr.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C422066.6040000@zytor.com> from "H. Peter Anvin" at Jan 13, 2002 04:03:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PvGX-0008Vz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I said: At 1 GB of userspace there is *no* address space which is 
> compatible with the normal address space map available to the user process.
> 
> There is mmap() space, available, sure, but you can't get the same 
> address, even by request.  Applications that care about the layout of 
> the address space will fail.

That sounds a good reason to run this mode a bit for debugging (be sure to
use Hugh's gcc 2.95/egcs-1.1.2 bug fix when trying this though!)
