Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263060AbUK0BZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbUK0BZN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbUK0BZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:25:08 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263060AbUKZTkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:40:37 -0500
Subject: Re: PATCH (for comment): ide-cd possible race in PIO mode
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041122075802.GL26240@suse.de>
References: <1100697589.32677.3.camel@localhost.localdomain>
	 <20041117153706.GH26240@suse.de>  <20041122075802.GL26240@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101137446.2756.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 24 Nov 2004 11:35:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-22 at 07:58, Jens Axboe wrote:
> > > +		spin_unlock_irqsave(&ide_lock, flags);
> > >  		return (*handler) (drive);
> > >  	}
> 
> btw alan, have you attempted to compile this? It averages 2 errors out
> of 4 lines :)

Guess why it said "for comment". The one that does compile is in current
-ac
but the fixes are kind of obvious 8)

