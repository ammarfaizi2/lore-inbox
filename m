Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265025AbUD2Wxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbUD2Wxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbUD2Wxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:53:42 -0400
Received: from gprs214-92.eurotel.cz ([160.218.214.92]:47746 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265025AbUD2Ww4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:52:56 -0400
Date: Fri, 30 Apr 2004 00:52:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Aviram Jenik <aviram@beyondsecurity.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: i830 success!
Message-ID: <20040429225247.GB8232@elf.ucw.cz>
References: <20040428103721.GA1057@elf.ucw.cz> <200404300145.04873.aviram@beyondsecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404300145.04873.aviram@beyondsecurity.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm very-very happy to say the patch below finally solved my swsusp problems 
> with the 2.6 kernel!
> 
> Here's some information about my setup:
> I'm using a vaio R505DL, which comes with an i830 video card. Swsusp2 worked 
> for me on the 2.4 kernel series, but I could never get any of the swsusp 
> implementations to work for me on the 2.5/2.6 series, unless the intel-agp 
> driver was unloaded (and this prevented X to work in a decent resolution).
> 
> Applying this patch to the 2.6.5 kernel enabled me to suspend using Pavel's 
> implementation (/proc/acpi/sleep).
> This patch also makes Nigel's swsusp2 code work with 2.6.5 - note that the 
> newest swsusp2 patches already include the patch below - so just applying 
> Nigel's 2.6.5 and core patches should get vaio users suspending.

> Thank you Pavel for your hard work, and thanks Nigel for making swsusp2 such a 
> robust suspending mechanism! You guys make Linux what it is.

Well, big thanks go to Herbert Xu who actually diagnosed this problem
in usefull way.
								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
