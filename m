Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268342AbUIGS4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268342AbUIGS4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268352AbUIGSNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:13:37 -0400
Received: from verein.lst.de ([213.95.11.210]:65437 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268336AbUIGSNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:13:07 -0400
Date: Tue, 7 Sep 2004 20:12:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mark install_page static
Message-ID: <20040907181259.GA12654@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040907143741.GA8606@lst.de> <1094576968.9599.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094576968.9599.9.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 06:09:29PM +0100, Alan Cox wrote:
> On Maw, 2004-09-07 at 15:37, Christoph Hellwig wrote:
> > Not used anywhere in modules and it really shouldn't either.
> 
> Doesn't that happen (conveniently from some viewpoints Im sure) to break
> vmware ?

It happens because Arjan & I wrote up some scripts to find dead exports.
