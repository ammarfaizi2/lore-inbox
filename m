Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVACWZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVACWZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVACWWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:22:34 -0500
Received: from gprs214-29.eurotel.cz ([160.218.214.29]:12935 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261937AbVACWSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:18:30 -0500
Date: Mon, 3 Jan 2005 23:17:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: hugang@soulinfo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [hugang@soulinfo.com: [PATH]software suspend for ppc.]
Message-ID: <20050103221718.GC25250@elf.ucw.cz>
References: <20050103122653.GB8827@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103122653.GB8827@hugang.soulinfo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Date: Mon, 3 Jan 2005 20:25:57 +0800
> To: benh@kernel.crashing.org
> Subject: [PATH]software suspend for ppc.
> 
> Hi Benjamin Herrenschmidt:
> 
>   Here is a patch to make ppc32 support suspend, Test passed in my
>   PowerBook, against with 2.6.10-mm1. Have a look. :)
> 
>   I'm also someone can do more test with it. 

swsusp_arch_{suspend,resume} should really be written in
assembly. Just compile this, disassemble it and put it into source
file. Otherwise it looks OK.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
