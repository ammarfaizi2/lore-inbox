Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTEGRDI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264118AbTEGRDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:03:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27401 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264104AbTEGRDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:03:01 -0400
Date: Wed, 7 May 2003 10:15:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
In-Reply-To: <20030507164613.GN823@suse.de>
Message-ID: <Pine.LNX.4.44.0305071013001.2997-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 May 2003, Jens Axboe wrote:
> 
> I dunno what the purpose of that would be exactly, I guess to cater to
> some hardware odditites?

And testing. In particular, you might want to test whether a device 
properly supports 48-bit addressing, either from the kernel or from user 
programs.

Also, if you want to re-create some particular IO pattern for debugging, 
you may want to explicitly use 48-bit addressing.

		Linus

