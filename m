Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752182AbWFLTIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbWFLTIn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbWFLTIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:08:43 -0400
Received: from tim.rpsys.net ([194.106.48.114]:57491 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1752182AbWFLTIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:08:42 -0400
Subject: Re: sharp zaurus sl-5500 (collie): touchscreen now works
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       metan@seznam.cz, arminlitzel@web.de
In-Reply-To: <20060610202541.GA26697@elf.ucw.cz>
References: <20060610202541.GA26697@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 20:08:26 +0100
Message-Id: <1150139307.5376.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 22:25 +0200, Pavel Machek wrote:
> I hacked touchscreen driver a bit (with great help from metan) and it
> is now actually usable, without much filtering in userland.

That's good to know! :)

> (Very) dirty bigdiff is attached. Proper battery charging (very slow
> charging is done even without software help) and MMC/SD support are
> two biggest issues now -- on the kernel front.

As far as I can see, we should be able to use the existing driver once
we adapt the code for the SA1100 features. The charging circuitry is
very similar to the other models as far as I can tell.

MMC/SD is more of a problem. There is one person with the specs who
could write the driver but he can't pass them to anyone else :-(.

> On the userland front... any ideas where to get 2.6-compatible GPE
> environment? It would be nice to see X running :-). Bluetooth support
> would be nice bonus ;-).

You can build such an image with OpenEmbedded easily enough ;-). I guess
you're going to have to run it from the CF card though as the internal
flash isn't big enough and MMC/SD doesn't work?

Cheers,

Richard


