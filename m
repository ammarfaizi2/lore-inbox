Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263148AbSJBNIn>; Wed, 2 Oct 2002 09:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbSJBNIm>; Wed, 2 Oct 2002 09:08:42 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:48632 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263148AbSJBNIm>; Wed, 2 Oct 2002 09:08:42 -0400
Subject: Re: Dereferencing semaphores and atomic_t's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021002111625.B24770@flint.arm.linux.org.uk>
References: <20021002111625.B24770@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 14:21:08 +0100
Message-Id: <1033564868.23758.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 11:16, Russell King wrote:
> drivers/scsi/scsi_error.c:
> 
>         SCSI_LOG_ERROR_RECOVERY(3, printk("Wake up parent %d\n",
>                                           shost->eh_notify->count.counter));
> 

This is already fixed in 2.4 - just forward port the fixes

