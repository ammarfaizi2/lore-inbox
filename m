Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268892AbUJEJox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268892AbUJEJox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 05:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUJEJow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 05:44:52 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:27143 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268892AbUJEJov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 05:44:51 -0400
Date: Tue, 5 Oct 2004 10:44:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       benh@kernel.crashing.org, paulus@samba.org, greg@kroah.com
Subject: Re: [Kernel-janitors] [PATCH 2.6][1/12] arch/ppc/kernel/pci.c replace pci_find_device with pci_get_device
Message-ID: <20041005104443.A16871@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@lists.osdl.org, benh@kernel.crashing.org,
	paulus@samba.org, greg@kroah.com
References: <298570000.1096930681@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <298570000.1096930681@w-hlinder.beaverton.ibm.com>; from hannal@us.ibm.com on Mon, Oct 04, 2004 at 03:58:01PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 03:58:01PM -0700, Hanna Linder wrote:
> 
> As pci_find_device is going away I have replaced this call with pci_get_device.
> If someone with a PPC system could verify it I would appreciate it. This is the only
> one in ppc/kernel all the others are under ppc/platform. There will be 12 total.

what about adding a for_each_pci_dev macro that nicely hides these AND_ID
iterations?
