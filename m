Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUHGXAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUHGXAE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUHGXAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:00:04 -0400
Received: from the-village.bc.nu ([81.2.110.252]:32964 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264571AbUHGXAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:00:01 -0400
Subject: Re: [PATCH] cdrom: MO-drive open write fix (trivial)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stefan Meyknecht <sm0407@nurfuerspam.de>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408071412.17411.sm0407@nurfuerspam.de>
References: <200408061833.30751.sm0407@nurfuerspam.de>
	 <20040806220654.5e857bed.akpm@osdl.org> <20040807083835.GA24860@suse.de>
	 <200408071412.17411.sm0407@nurfuerspam.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091915848.19077.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 22:57:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-07 at 13:12, Stefan Meyknecht wrote:
> Jens Axboe <axboe@suse.de> wrote:
> > drive. If you could look into why that isn't set for your mo device
> > and send a patch for that, it would be much better.
> 
> Assuming mo devices can do random writing, how about this patch:

They can do so. I ended up using verified writes on mine because I found
MO devices pretty flakey and often needing retried reads or
write/verifies.

Maybe my drive just needs cleaning more.

