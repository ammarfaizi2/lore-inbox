Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269365AbUINNVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269365AbUINNVU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269371AbUINNSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:18:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44008 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269344AbUINNSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:18:18 -0400
Date: Tue, 14 Sep 2004 15:15:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: syphir@syphir.sytes.net, linux-kernel@vger.kernel.org,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Message-ID: <20040914131555.GW2336@suse.de>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net> <200409141359.27558.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409141359.27558.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2004, Bartlomiej Zolnierkiewicz wrote:
> > Thanks for the explanation.  I can understand that some of the older drives
> > will not support FLUSH_CACHE which is acceptable. On another note, since
> > most computers only have IDE0 and IDE1 slots, is there a way to prevent the
> > probe from returning errors on boot when looking for IDE2 to IDE5?  Perhaps
> 
> errros?  these are innocent KERN_DEBUG messages

To a user, they look like errors.

-- 
Jens Axboe

