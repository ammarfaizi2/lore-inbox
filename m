Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUCHQ2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 11:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbUCHQ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 11:28:46 -0500
Received: from quasar.dynaweb.hu ([195.70.37.87]:49823 "EHLO quasar.dynaweb.hu")
	by vger.kernel.org with ESMTP id S262598AbUCHQ2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 11:28:45 -0500
Date: Mon, 8 Mar 2004 17:28:39 +0100
From: Rumi Szabolcs <rumi_ml@rtfm.hu>
To: Mike Fedyk <mfedyk@matchmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Marvell PATA-SATA bridge meets 2.4.x
Message-Id: <20040308172839.17178753.rumi_ml@rtfm.hu>
In-Reply-To: <404A9D14.5030107@matchmail.com>
References: <20040305231642.708841dd.rumi_ml@rtfm.hu>
	<404A9D14.5030107@matchmail.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; sparc-sun-solaris2.9)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Mar 2004 19:55:00 -0800
Mike Fedyk <mfedyk@matchmail.com> wrote:

> Rumi Szabolcs wrote:
> > As it can be seen below, a native SATA150 drive is connected
> > to a SATA port implemented using that Marvell chip hooked up
> > to the ICH4's parallel ATA133 port and this way the drive is
> > only recognized (and used) as UDMA33:
> > 
> > hdc: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(33)
> > 
> > As far as I can remember someone (Jeff Garzik?) suspected the
> > SATA cable not being recognized as a 80-conductor thus >=UDMA66
> > capable cable. Then it was told that there is a fix underway that
> > will be included in the 2.4.23 kernel. The above snippet shows
> > that the 2.4.25 kernel still has this problem. Any comments?
> 
> You want to use a 2.6 kernel and talk to Bart, and Jeff about this...

Well, I don't really want a 2.6 kernel on that machine (yet) because
in my opinion it is not stable enough for a production system.

Would it be hard to fix that in 2.4?

Regards,
Szabolcs Rumi
