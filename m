Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVKCO6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVKCO6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVKCO6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:58:14 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:45097 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030233AbVKCO6N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:58:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AUx1hvPnMqxjKUQZ5I2CBEIM9dQqx1LzMiNjxSn5bAP731Xjb15ufzzsH9gOWXuyJYgROwaD8G9r3BtKHUpvRa6E71kqtSw7d7Zxd+jtBvSZv60+nTCv2ro35NmI7kHar2L7nWqGOAdHc5PZFFbQGjAvVVf511bM/WaNuC0YBaU=
Message-ID: <58cb370e0511030658tb23cecds2ed8cc63570a68d5@mail.gmail.com>
Date: Thu, 3 Nov 2005 15:58:12 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Parallel ATA with libata status with the patches I'm working on
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131029686.18848.48.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1131029686.18848.48.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Core Features Fixed
> - Per drive tuning
> - Filter quirk lists
> - Single channel support

Are these the same changes that have been recently pushed into
Linus' tree without any previous public review or some new ones?

> And To Add
> - Specify PCI bus speed
> - HPA
> - IRQ mask
> - PIO only LBA48
> - Serialize
> - CRC downspeed
> - Mixed legacy/native mode (most work done)
>
> Drivers so far written for the libata parallel work I'm doing

Are the patches available somewhere?

> ALI
> Driver written with equivalent support to the drivers/ide one. Needs
> core changes for LBA48 PIO only
>
> AMD
> Driver written, given basic testing and equivalent to current
> drivers/ide

Functionality can't be the same as drivers/ide because libata
lacks some core features.

> CS5520
> Driver written, some debug work to do. Works unlike the drivers/ide one

Please fix drivers/ide also if not a big problem.

> HPT34X
> Driver written, functionality same as drivers/ide. Needs more testing.

Same comment as for AMD.

> Serverworks
> Written, equivalent functionality to drivers/ide plus some bugs fixed

Ditto.  Also please backport fixes to drivers/ide.

Thanks,
Bartlomiej
