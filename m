Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269272AbUINLUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269272AbUINLUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269273AbUINLPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:15:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42929 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269270AbUINLNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:13:12 -0400
Date: Tue, 14 Sep 2004 13:11:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Message-ID: <20040914111137.GQ2336@suse.de>
References: <20040914060628.GC2336@suse.de> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net> <20040914070649.GI2336@suse.de> <1095156428.16571.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095156428.16571.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2004, Alan Cox wrote:
> On Maw, 2004-09-14 at 08:06, Jens Axboe wrote:
> > They do support it, they just don't flag the support in the capability
> > flags. And of course some don't support it at all, you can try this on
> > your drives if you want to know for sure.
> 
> You have data sheets to prove this ?

Nope, good luck finding that. The only info I have is common sense
(which doesn't always apply, granted) and timing I did on the one such
drive I have here that doesn't flag support for FLUSH_CACHE but also
doesn't error the command.

-- 
Jens Axboe

