Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUB1Qyx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 11:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUB1Qyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 11:54:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37276 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261877AbUB1Qyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 11:54:52 -0500
Message-ID: <4040C7CF.4020108@pobox.com>
Date: Sat, 28 Feb 2004 11:54:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: de@axiros.com
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.25: Get rid of obsolete LMC driver
References: <1077972033.24149.399.camel@sonja>
In-Reply-To: <1077972033.24149.399.camel@sonja>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:
> Hi Marcello,
> 
> This patch plus an additional
> rm -r drivers/net/wan/lmc
> gets rid of the obsolete LMC WAN driver and all references to it in the
> Configure.in and Makefiles and MAINTAINERS.
> 
> When LMC was taken over by SBE their kernel version of the driver went
> effectively unmaintained after Alan Cox turned down their LMC->SBE
> rename patch. Today SBE recommends their own version of the driver only
> which unfortunately needs different tools and also clashes with the LMC
> driver when not compiled as module. This general recommendation from
> their support effectively makes the in-kernel code obsete.
> 
> Their drivers can be retrieved from:
> ftp://ftp.sbei.com/pub/OpenSource/Linux/sbe_driver/sbe_linux-4.0a.tgz

Alan Cox vetoed a rename patch, so you want to rip out the driver 
instead???  For an unreviewed out-of-tree driver?

Without a suitable replacement, I don't give a shit about what SBE 
recommends.

Veto.

	Jeff



