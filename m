Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWABWdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWABWdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 17:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWABWdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 17:33:52 -0500
Received: from [81.2.110.250] ([81.2.110.250]:61127 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751109AbWABWdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 17:33:51 -0500
Subject: Re: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver
	for PDC202XX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: 1qay beer <1qay@beer.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060101173909.D30257B386@ws5-10.us4.outblaze.com>
References: <20060101173909.D30257B386@ws5-10.us4.outblaze.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Jan 2006 22:35:51 +0000
Message-Id: <1136241351.8570.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-01-01 at 13:39 -0400, 1qay beer wrote:
> Hello,
> Dear Alan Cox,
> Dear Jeff Garzik,
> 
> Everyone a happy new year!

Ditto

> -The IDE Driver (pdc202xx_new) has still problems with "DMA Timeout".

The legacy IDE layer is handled by Bartlomiej so you should direct your
enquiries and requests to him and the linux-ide list.

> -The Libata Driver (pata_pdc2027x) seems to be still somewhat experimental.

and while I'm working on libata pata a fair bit the pdc202xx driver is
the excellent work of Albert Lee.

The 20269 has always shown up as a problem for some users but not for
most. Nobody ever really got to the bottom of it to be honest. Please
send Albert your reports about which hardware works and which fails
(<albertcc@tw.ibm.com>) as it may be very useful. In particular the
drive that works appears to be UDMA 100 and the failing one UDMA 133

Alan

