Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965477AbWI0Jda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965477AbWI0Jda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965476AbWI0Jd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:33:29 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:35755 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965474AbWI0Jd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:33:28 -0400
Message-ID: <451A4565.2080601@garzik.org>
Date: Wed, 27 Sep 2006 05:33:25 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: genestapp@charter.net
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SATA: Marvell 88SE6141 kernel support?
References: <393855126.1159346763423.JavaMail.root@fepweb13>
In-Reply-To: <393855126.1159346763423.JavaMail.root@fepweb13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

genestapp@charter.net wrote:
> I talked to Gord Peters who asked about this sata chip in June. He said there is a experimental patch for it, but the one he had was an old version. I've been looking all over but could not find it. Also I've checked the newest linux kernel builds and there is no mention of mv_61x support. Does anyone know the status of kernel support for this chip? I'm running 2.6.17 kernel currently but will be upgrading to .18 on Thursday (FC5)
> 
> I'm using the Asus P5WD2-E motherboard. I've already used the 4 sata ports on the ICH7 chip and I'm looking to expand my software raid 5 array with a couple more drives (and more later).
> For reference, this was the earlier thread from archives:
> http://lkml.org/lkml/2006/6/14/259

This chip is vastly different from sata_mv.

For the SATA portion (not PATA), you might have some luck adding your 
PCI ID to ahci.c.  Give that a try, and let us know if it works or 
explodes :)

Other than that, no progress at all to report.  Marvell just provided 
the documentation to me, but I've made no progress yet.

	Jeff



