Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbTIJQW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbTIJQW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:22:26 -0400
Received: from havoc.gtf.org ([63.247.75.124]:64405 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265109AbTIJQWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:22:20 -0400
Date: Wed, 10 Sep 2003 12:17:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Fruhwirth Clemens <clemens-dated-1064072339.1427@endorphin.org>
Cc: linux-kernel@vger.kernel.org, cryptoapi-devel@kerneli.org
Subject: Re: [PATCH] AES i586-asm optimized
Message-ID: <20030910161738.GA29990@gtf.org>
References: <20030910153859.GA17919@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910153859.GA17919@leto2.endorphin.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 05:38:59PM +0200, Fruhwirth Clemens wrote:
> This patch[1] adds an i586 assembler optimized version of the Rijndael (AES)
> cipher. Please have a look, try, and criticise.
> 
> Before starting the old "do we need assembler" thread again: 
> As tested by hvr[2] this implemention is significantly faster than the C 
> version.

Tested on what processors?  With what kernel config?

I would be surprised if a 586-optimized asm was useful on P4.


> Guys, the linux kernel doesn't even compile with icc (Intel C
> compiler)

Wrong.  As Intel pointed out on linux-kernel less than 24 hours ago,
even.


> These are the raw numbers. Assembler is faster. 

gcc generates assembler, so this is nonsensical ;-)


> And before we start to discuss a sophisticated framework for assembler
> implemention or automatic selection of implementions or preferences by
> application for a particular implemention and so one: This is the first
> assembler implemention and most likely the last for a long time.

Nope, S/390 folks beat ya to it.

And I'm working on something as well.


> So I think
> with this perspective it's not worth delaying this feature, especially
> because after this module disk encryption becomes reasonable.

In your opinion.

	Jeff



