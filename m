Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268400AbUIGSkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268400AbUIGSkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268356AbUIGSid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:38:33 -0400
Received: from verein.lst.de ([213.95.11.210]:20638 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268407AbUIGS3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:29:17 -0400
Date: Tue, 7 Sep 2004 20:29:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mark install_page static
Message-ID: <20040907182909.GA13021@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040907143741.GA8606@lst.de> <1094576968.9599.9.camel@localhost.localdomain> <20040907181259.GA12654@lst.de> <1094577937.9599.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094577937.9599.21.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 06:25:38PM +0100, Alan Cox wrote:
> > It happens because Arjan & I wrote up some scripts to find dead exports.
> 
> Sure. Most of them look good but some of them look a little dubious. Now
> as I was asking - doesn't this break vmware ?

And the answer is:  I don't know because the vmware module license isn't
free software and thus I haven't taken a look.  Given Petr's answer
probably yes - but because it's above mentioned license I don't
particularly care.

