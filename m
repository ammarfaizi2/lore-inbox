Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUIGRrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUIGRrC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUIGRrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 13:47:02 -0400
Received: from verein.lst.de ([213.95.11.210]:37789 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266149AbUIGRqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 13:46:55 -0400
Date: Tue, 7 Sep 2004 19:46:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] mark install_page static
Message-ID: <20040907174649.GA12239@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <2E70CD2670F@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E70CD2670F@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 07:46:33PM +0200, Petr Vandrovec wrote:
> On  7 Sep 04 at 16:37, Christoph Hellwig wrote:
> > Not used anywhere in modules and it really shouldn't either.
> 
> How are modules supposed to implement vma's populate method
> without having install_page available?  And yes, there are
> out of tree kernel modules which prefer fremap & populate & install_page
> over creating several thousands of VMAs to get non-linear mappings.

Submit them fo inclusion and we can consider them.
