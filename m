Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269998AbUJNIeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269998AbUJNIeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 04:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269999AbUJNIeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 04:34:15 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:39685 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269998AbUJNIeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 04:34:13 -0400
Date: Thu, 14 Oct 2004 09:34:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, chas@cmf.nrl.navy.mil,
       greg@kroah.com
Subject: Re: [KJ] [PATCH 2.6] fore200e.c replace pci_find_device with pci_get_device
Message-ID: <20041014083410.GA7747@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hanna Linder <hannal@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	kernel-janitors <kernel-janitors@lists.osdl.org>,
	chas@cmf.nrl.navy.mil, greg@kroah.com
References: <194130000.1097705759@w-hlinder.beaverton.ibm.com> <196790000.1097705910@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196790000.1097705910@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 03:18:30PM -0700, Hanna Linder wrote:
> 
> 
> As pci_find_device is going away soon I have converted this file to use
> pci_get_device instead. I have compile tested it. If anyone has this ATM card
> and could test it that would be great.

Again this driver should be converted to pci_driver.  What you did didn't
plug the hotplug races anyway.


