Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268352AbUIGS4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268352AbUIGS4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268355AbUIGSOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:14:16 -0400
Received: from verein.lst.de ([213.95.11.210]:61853 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268314AbUIGSLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:11:36 -0400
Date: Tue, 7 Sep 2004 20:11:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] unexport get_wchan
Message-ID: <20040907181130.GA12595@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040907144539.GA8808@lst.de> <1094576868.9607.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094576868.9607.7.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 06:07:49PM +0100, Alan Cox wrote:
> On Maw, 2004-09-07 at 15:45, Christoph Hellwig wrote:
> > only usedby procfs which certainly can't be modular
> 
> And multiple out of tree debuggers. Christoph - do some basic homework.
> Also save the "so merge it" crap for someone else before you come up
> with that comment. Given the choice between a few exports of relevant
> functionality and merging some of the open source stuff that uses it we
> are far far better off with the export.
> 
> Plus Linus has a random personal and unreasonable hatred of debugging
> tools so they'll never get merged anyway without forking the kernel.

Which debuging tool?  Both kdb and xmon don't use it.
