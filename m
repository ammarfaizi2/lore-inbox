Return-Path: <linux-kernel-owner+w=401wt.eu-S1161215AbXAHKTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbXAHKTm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 05:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbXAHKTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 05:19:42 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47335 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161212AbXAHKTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 05:19:41 -0500
Date: Mon, 8 Jan 2007 10:30:26 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH libata #promise-sata-pata] sata_promise: 2037x PATAPI
 support
Message-ID: <20070108103026.230470a8@localhost.localdomain>
In-Reply-To: <45A1A2B7.8000601@garzik.org>
References: <200701072239.l07Mdju7028895@harpo.it.uu.se>
	<45A1A2B7.8000601@garzik.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMO creating a new check_atapi_dma function for first-gen chips would be 
> the preferred way to add this check.

A mode filter would be even better, that will mean the list of modes on
the device is correct and ATAPI devices are shown as PIO on such a
controller.
