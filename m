Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRHaQty>; Fri, 31 Aug 2001 12:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbRHaQte>; Fri, 31 Aug 2001 12:49:34 -0400
Received: from mout1.freenet.de ([194.97.50.132]:16546 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S268133AbRHaQt0>;
	Fri, 31 Aug 2001 12:49:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Franck <afranck@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Messages "ACPI attempting to access kernel owned memory"?
Date: Fri, 31 Aug 2001 18:49:30 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15cojW-0003B7-00@the-village.bc.nu>
In-Reply-To: <E15cojW-0003B7-00@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01083118493000.00929@dg1kfa>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan, hello linux-kernel,

> > No, your code is all right, I have found the cause of this behaviour:
> > it's because I boot with GRUB and not with LILO. So, you might say "What
> > the hell does the bootloader matter", and this is what I also thought in
> > the first hours, until I noticed that GRUB was adding a "mem=524288K"
> > entry to my
>
> This is a known problem with old versions of GRUB. Up to date versions of
> grub shouldnt be passing mem= lines.

So I'll try to get a newer GRUB, the --no-mem-option suggestion from Jan 
Niehusmann didn't work for me (using GRUB version 0.5.96.1). But, 
nevertheless, shouldn't this be fixed (not reserving ACPI memory when a mem= 
commandline is passed)? Or, at least documented somewhere?

Greetings,
Andreas

