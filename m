Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbTE1Jsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 05:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbTE1Jsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 05:48:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35284 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264639AbTE1Jsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 05:48:30 -0400
Date: Wed, 28 May 2003 12:01:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Ragnar Hojland Espinosa <ragnar@linalco.com>,
       manish <manish@storadinc.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528100135.GM845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <200305271954.11635.m.c.p@wolk-project.de> <20030528093654.GA20687@linalco.com> <200305281153.15317.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305281153.15317.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Marc-Christian Petersen wrote:
> On Wednesday 28 May 2003 11:36, Ragnar Hojland Espinosa wrote:
> 
> Hi Ragnar,
> 
> > Actually it just happens in the fixing stage when burning prebuilt iso
> > images from the hard disk (same IDE channel as the burner, 2.4.20)
> > Having a completely frozen machine under X was quite panic inducing ;)
> That's a problem of IDE itself. I still say IDE is broken by design ;-)

It is actually possible to use the IMMED bit of the CLOSE_TRACK command
to get around this. In that case the cd-r will return the command as
completed and the drive on the same channel can service requests.

-- 
Jens Axboe

