Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267833AbUHERrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267833AbUHERrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267835AbUHERrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:47:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:709 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267833AbUHERqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:46:39 -0400
Date: Thu, 5 Aug 2004 19:46:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040805174619.GK12483@suse.de>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de> <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <1091490870.1649.23.camel@localhost.localdomain> <20040803055337.GA23504@suse.de> <20040803161747.GA16293@bliss> <20040804050144.GB8139@suse.de> <1091721152.8042.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091721152.8042.16.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, Alan Cox wrote:
> On Mer, 2004-08-04 at 06:01, Jens Axboe wrote:
> > Absolutely not. I've already outlined why in my previous mails I don't
> > want to see anything like this, and this patch is even worse than
> > filtering. Additionally, you risk breaking existing programs.
> 
> Existing broken programs. 
> 
> Once you do filtering so you don't need CAP_SYS_RAWIO to lob some
> commands at a device that becomes the place to enforce sensible policies
> because the filter knows what is "read" and what is "write" so it can do
> different checks for say "eject" (read) "write" (write) and "erase
> firmware" (raw I/O)

Alan, there will be _no_ filtering.

-- 
Jens Axboe

