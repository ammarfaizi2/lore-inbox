Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130520AbRCMM7v>; Tue, 13 Mar 2001 07:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130616AbRCMM7l>; Tue, 13 Mar 2001 07:59:41 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:35496 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130520AbRCMM7e>; Tue, 13 Mar 2001 07:59:34 -0500
Message-ID: <3AAE196E.ADE55CB9@yahoo.co.uk>
Date: Tue, 13 Mar 2001 07:58:22 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac16 PIIX4 ACPI getting wrong IRQ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > So the ACPI function of the PIIX4 is now being given
> > IRQ 9.  I don't want this.  I was using IRQ 9 for a
> > PCMCIA device.
> 
> It was always being given IRQ 9, now we correctly handle this. 

Okay, but.  IRQs are scarce.  With previous kernels I was able
to use IRQ 9 for other things without any obvious problems.
Perhaps this is only because I don't have ACPI support enabled.
Still, if I disable ACPI support then shouldn't I be able to use
IRQ 9 for other things?  If so, shouldn't the kernel to refrain
from reserving this IRQ?

Thomas Hood
jdthood_AT_yahoo.co.uk
