Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269091AbUIXTCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269091AbUIXTCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 15:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269093AbUIXTCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 15:02:39 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:19218 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269091AbUIXTCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 15:02:38 -0400
Date: Fri, 24 Sep 2004 20:02:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       kernel-janitors@lists.osdl.org, davej@codemonkey.org.uk, hpa@zytor.com
Subject: Re: [PATCH 2.6.9-rc2-mm2] Create new function to see if pci dev is present
Message-ID: <20040924200231.A30391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
	greg@kroah.com, kernel-janitors@lists.osdl.org,
	davej@codemonkey.org.uk, hpa@zytor.com
References: <2480000.1095978400@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2480000.1095978400@w-hlinder.beaverton.ibm.com>; from hannal@us.ibm.com on Thu, Sep 23, 2004 at 03:26:40PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 03:26:40PM -0700, Hanna Linder wrote:
> 
> Greg asked in a previous janitors thread:
> "What we need is a simple "Is this pci device present right now" type
> function, to solve the mess that logic like this needs."
> 
> OK. How about this one? It uses pci_get_device but instead of returning
> the dev it returns 1 if the device is present and 0 if it isnt. This take the
> burdon off the driver from having to know when to use pci_dev_put or
> not and should be cleaner for future maintenance work.
> 
> Ive tested it with two patches that will follow.

Please include subdevice/subvendor id

