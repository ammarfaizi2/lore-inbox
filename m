Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUIGS4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUIGS4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268430AbUIGSyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:54:33 -0400
Received: from verein.lst.de ([213.95.11.210]:44702 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268505AbUIGStP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:49:15 -0400
Date: Tue, 7 Sep 2004 20:49:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] unexport get_wchan
Message-ID: <20040907184907.GA13331@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040907144539.GA8808@lst.de> <1094576868.9607.7.camel@localhost.localdomain> <20040907181130.GA12595@lst.de> <1094578157.9607.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094578157.9607.25.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 06:29:18PM +0100, Alan Cox wrote:
> On Maw, 2004-09-07 at 19:11, Christoph Hellwig wrote:
> > Which debuging tool?  Both kdb and xmon don't use it.
> 
> You broke my kgdb 8) 

Well, you kdb cotains quite a few other patches to core code already,
no?  And it could add back a single EXPORT_SYMBOL in a common place
instead of duplicated over every architecture..
