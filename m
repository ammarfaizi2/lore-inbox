Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVAKCGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVAKCGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVAKCFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:05:36 -0500
Received: from [220.248.27.114] ([220.248.27.114]:15820 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262608AbVAKCC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:02:56 -0500
Date: Tue, 11 Jan 2005 10:01:13 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software suspend patch [1/6]
Message-ID: <20050111020112.GB22398@hugang.soulinfo.com>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net> <20041128113708.GQ1417@openzaurus.ucw.cz> <20041128162320.GA28881@hugang.soulinfo.com> <20041128165835.GA1214@elf.ucw.cz> <20041129154307.GC4616@hugang.soulinfo.com> <20050109224325.GE1353@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050109224325.GE1353@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 11:43:25PM +0100, Pavel Machek wrote:
> Hi!
> 
> Do you have any updates? It would be nice to separate non-continuous
> pagedir from speeding up check_pagedir?
> 
> ...plus check_pagedir should really use PageNosaveFree flag instead of
> allocating there own (big!) bitmaps. It should also make the code
> simpler...
> 								Pavel

I'm very happy with current swsusp, that's stable for me. 
 2.6.10-mm1 + ppc patch from 
  http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/
 + your free some memory patch

I using it for a week, never failed, never oops. :)

The only problem is relocating a little slowly.

Now I don't think non-continuous pagedir is really need. Anyway I'll
prepare a patch to make swsusp using non-continuous pagedir.

any comments.

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
