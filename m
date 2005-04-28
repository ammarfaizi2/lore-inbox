Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVD1RZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVD1RZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVD1RZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:25:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63114 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262181AbVD1RZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:25:46 -0400
Date: Thu, 28 Apr 2005 19:25:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE problems with rmmod ide-cd
Message-ID: <20050428172541.GN1876@suse.de>
References: <1114706653.18330.212.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114706653.18330.212.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28 2005, Alan Cox wrote:
> If you rmmod ide-cd in 2.6.12rc3 it issues a cache flush command to the
> drive. Thankfully the bogus command this time is an ATAPI cache flush
> not an ATA one so won't do any major harm but its still wrong as the
> device is not a writer or packet mode capable (its a random DVD reader
> holding a music CD)

The problem you are thinking of was also an ATAPI cache flush command,
so I'm not so sure I would call it harmless... I haven't changed
anything in there recently, Bart?

-- 
Jens Axboe

