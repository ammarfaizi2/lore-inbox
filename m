Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVBCKUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVBCKUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVBCKUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:20:24 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:19119 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262509AbVBCKUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:20:15 -0500
X-Envelope-From: kraxel@bytesex.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>, mathieu.okuyama@free.fr
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc3 - BT848 no signal
References: <Pine.LNX.4.58.0502021824310.2362@ppc970.osdl.org>
	<1107407987.2097.18.camel@lb.loomes.de>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 03 Feb 2005 11:17:41 +0100
In-Reply-To: <1107407987.2097.18.camel@lb.loomes.de>
Message-ID: <87is5a0wxm.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Trippelsdorf <markus@trippelsdorf.de> writes:

> tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
> tuner: type set to 33 (MT20xx universal) by bt878 #0 [sw]
> tuner: microtune: companycode=4d54 part=04 rev=04
> tuner: microtune MT2032 found, OK
> tda9885/6/7: chip found @ 0x86
> ...
> mt2032_set_if_freq failed with -121

Can you please load tuner.o with debug=1, tda9887.o with debug=2 and
mail me the logs for driver load + attempt to tune some station for
both working and non-working kernel please?

Thanks,

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
