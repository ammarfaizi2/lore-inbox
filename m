Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272618AbTG1CEU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272071AbTG1CDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 22:03:16 -0400
Received: from [200.199.201.175] ([200.199.201.175]:62899 "EHLO
	smtp3.brturbo.com") by vger.kernel.org with ESMTP id S271033AbTG1CBj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 22:01:39 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
Date: Sun, 27 Jul 2003 20:11:51 -0300
User-Agent: KMail/1.5.9
Cc: Rahul Karnik <rahul@genebrew.com>, lkml <linux-kernel@vger.kernel.org>,
       Laurens <masterpe@xs4all.nl>
References: <200307262309.20074.adq_dvb@lidskialf.net> <200307271301.41660.adq_dvb@lidskialf.net> <3F2477C4.2000105@pobox.com>
In-Reply-To: <3F2477C4.2000105@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307272011.51631.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No luck here, Jeff ... if the hardware is really based on AMD8111 as it 
appears to be (i2c and ide are similar), they surelly changed more registers. 
It'll take some time to RE it.

And I don't know how important is this information, but it doesn't get the 
iobase addr either and it can't be manually set in ifconfig.

Marcelo Penna Guerra

On Sunday 27 July 2003 22:09, Jeff Garzik wrote:
> One can set the MAC address manually via ifconfig.
>
> So, try modprobing amd8111e with the nforce pci ids, then manually
> setting the MAC address, and see if that works.
>
> (just make sure the MAC address you make up is unique)
>
> 	Jeff
