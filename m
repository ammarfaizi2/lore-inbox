Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283134AbRK2KSJ>; Thu, 29 Nov 2001 05:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283135AbRK2KRt>; Thu, 29 Nov 2001 05:17:49 -0500
Received: from smtp-rt-10.wanadoo.fr ([193.252.19.59]:47502 "EHLO
	camelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S283134AbRK2KRp>; Thu, 29 Nov 2001 05:17:45 -0500
Date: Thu, 29 Nov 2001 10:58:43 +0100 (CET)
From: Pascal Lengard <pascal.lengard@wanadoo.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pascal Lengard <pascal.lengard@wanadoo.fr>, <lnz@dandelion.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: dac960 broken ?
In-Reply-To: <E1696sR-0005C0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111291055080.15974-100000@h2o.chezmoi.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

Sorry, I must apology here. I just rerun the redhat kernel and the error
is not linked to ext3fs (anyway it made no sens since the user base of
ext3 is HUGE and no problem was reported ...).

The problem is linked to DAC960 also:
here are the messages:

	Loading scsi_mod module
	Loading DAC960 module
	/lib/DAC960.o: init_module: Operation not permitted
	Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
	ERROR /bin/insmod exited abnormally!
	Loading jbd module
	Journalled Block Device driver loaded
	Loading ext3 module
	Mounting /proc filesystem
	Creaing root device
	Mounting root filesystem
	mount: error 19 mounting ext3
	pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
	Freeing unused kernel memory: 216k freed
	Kernel panic: No init found. Try passing init= option to kernel

Pascal Lengard

On Wed, 28 Nov 2001, Alan Cox wrote:
> You don't provide enough information. Precisely what symbols, precisely what
> error message
> 
> Alan
> 

