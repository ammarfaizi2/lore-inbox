Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVASXuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVASXuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVASXuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:50:19 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:32412 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261979AbVASXpT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:45:19 -0500
X-Envelope-From: kraxel@bytesex.org
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kbuild 2/5] Dont use the running kernels config file by default
References: <20050118184123.729034000.suse.de>
	<20050118192608.423265000.suse.de>
	<Pine.LNX.4.61.0501182106340.6118@scrub.home>
	<1106157119.8642.25.camel@winden.suse.de>
	<Pine.LNX.4.61.0501191858060.30794@scrub.home>
	<1106160130.8642.46.camel@winden.suse.de>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 20 Jan 2005 00:41:43 +0100
In-Reply-To: <1106160130.8642.46.camel@winden.suse.de>
Message-ID: <877jm9ugug.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> writes:

> The user does a ``make menuconfig'', and expects to see sane defaults.
> What kconfig really does is take the running kernel's configuration
> instead. This is a ad choice; it makes much more sense to take
> arch/$ARCH/defconfig.

IIRC the vanilla kernel's arch/i386/defconfig is the "this config
boots Linus' machine" configuration (or has that changed recently?).
I certainly wouldn't call that a sane default ...

For vendor kernels with a generic defconfig that makes sense though.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
