Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVF1N6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVF1N6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 09:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVF1N4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 09:56:15 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57559 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261862AbVF1NvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 09:51:22 -0400
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:
	nobody cared!"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Fieroch <Fieroch@web.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, bzolnier@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alexey Dobriyan <adobriyan@gmail.com>, akpm@osdl.org,
       Natalie.Protasevich@UNISYS.com
In-Reply-To: <42C0953B.8000506@web.de>
References: <d6gf8j$jnb$1@sea.gmane.org>
	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>
	 <58cb370e05061401041a67cfa7@mail.gmail.com> <42B091EE.4020802@web.de>
	 <20050615143039.24132251.akpm@osdl.org>
	 <1118960606.24646.58.camel@localhost.localdomain> <42B2AACC.7070908@web.de>
	 <1119011887.24646.84.camel@localhost.localdomain> <42B302C2.9030009@web.de>
	 <9a874849050617101712b80b15@mail.gmail.com>  <42C0953B.8000506@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119966469.32381.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Jun 2005 14:47:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Running the mm2 kernel with "ITE IT8212 RAID CARD support" enabled and 
> compiled into the kernel I get a kernel panic:

That driver fakes your IDE controller as scsi so it moved your rootfs.


