Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263676AbUDWA43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbUDWA43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 20:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUDWA43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 20:56:29 -0400
Received: from gprs214-221.eurotel.cz ([160.218.214.221]:19584 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263676AbUDWA40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 20:56:26 -0400
Date: Fri, 23 Apr 2004 02:56:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SOFTWARE_SUSPEND as a module
Message-ID: <20040423005617.GA414@elf.ucw.cz>
References: <20040422120417.GA2835@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422120417.GA2835@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is a quick hack to modularise SOFTWARE_SUSPEND.  I've successfully
> suspended to/resumed from LVM using this.

Uh, oh.

I can't see actual code changes because you do lots of renames... Is
there way to keep them down?

What is the point of this? Do you want launch resume after you
prepared for it in userland? In such case you need to add
freeze_processes() to resume path.

[And please inline your patches. l-k policy says so and my mail filter
learned that attachment == virus. (At 500 viruses a day, its
unfortunately close to right).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
