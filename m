Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWBTR23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWBTR23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbWBTR23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:28:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38604 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161068AbWBTR22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:28:28 -0500
Subject: Re: Missing file
From: Arjan van de Ven <arjan@infradead.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0602201201200.4888@chaos.analogic.com>
References: <Pine.LNX.4.61.0602201201200.4888@chaos.analogic.com>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 18:28:25 +0100
Message-Id: <1140456505.2979.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 12:08 -0500, linux-os (Dick Johnson) wrote:
> 
> Hello,
> Linux-2.6.15.4 fails to contain the file:
>  	/usr/src/linux-2.6.15.4/drivers/pci/devlist.h
> 
> This contains product NAMES used to identity various PCI
> devices when they are installed. What replaces this file?
> 
> The file existed up until at least linux-2.6.13.4 and
> should not have been removed just because some audit
> may have determined that it's "not in use." It is in
> use by vendors which need to convert "Computerese" to
> "Customer readable" stuff.


actually an entirely different file is used for that;
/usr/share/hwdata/pci.ids

which comes from the pci id repo on sourceforge (same as the file you
want to look at). Distributions at least tend to update pci.ids file
more frequent than the kernel updated devlist.h...


