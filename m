Return-Path: <linux-kernel-owner+w=401wt.eu-S932206AbWLLRvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWLLRvL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWLLRvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:51:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53011 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932206AbWLLRvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:51:10 -0500
Date: Tue, 12 Dec 2006 17:59:20 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Andrew Robinson" <andrew.rw.robinson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 is not stable with SATA and should not be used by any
 means
Message-ID: <20061212175920.0b15a1fb@localhost.localdomain>
In-Reply-To: <bc36a6210612120920h283c2d81q137bb9698a0cefb5@mail.gmail.com>
References: <bc36a6210612120920h283c2d81q137bb9698a0cefb5@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 10:20:35 -0700
"Andrew Robinson" <andrew.rw.robinson@gmail.com> wrote:

> So I went back into config, and saw that the SATA drivers were gone,
> replaced by experimental EATA drivers. Not seeing any way to continue
> to use the sata_nv without these EATA drivers, I went ahead and used
> those settings.

The SATA drivers are still there. The IDE drivers are
there and haven't moved. I'm not sure what you mean by "EATA drivers".
The EATA is an old SCSI controller series. What did you actually select ?

> backup of the files I could get to, I ran this, and now the file
> system is complete destroyed (there are no init levels left).

Neither drivers/ide nor 2.6.19 drivers/ata support suspend to ram.
 
> Could someone enlighten me why hard drive drivers that are
> experimental were put into a "stable" kernel version? 

In the case of the Nvidia SATA and PATA driver, because they passed months
of testing and nobody hit any problems with them.

> 2.6.19 or were the ones that work removed completely? Unfortunately,

Given you keep burbling about EATA drivers it's hard to guess what you
are even asking. Assuming you mean drivers/ide - it never supported the
SATA Nvidia ports. The PATA Nvidia ports are supported by drivers/ide or
drivers/ata (your choice)

> Looks like Linux developers prefer the overpriced and under powered
> Intel chips instead unfortunately.
> 
> Thanks for any help that you can provide.

Well I was considering help and advice but since you've nothing better to
do but insult people with stupid commentd about Intel chips I've put you
in my killfile instead.

Alan
