Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVGVNzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVGVNzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 09:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVGVNzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 09:55:36 -0400
Received: from unthought.net ([212.97.129.88]:1238 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261279AbVGVNze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 09:55:34 -0400
Date: Fri, 22 Jul 2005 15:55:33 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 10 GB in Opteron machine
Message-ID: <20050722135532.GJ30510@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Christoph Pleger <Christoph.Pleger@uni-dortmund.de>,
	linux-kernel@vger.kernel.org
References: <20050722105516.6ccffb8f.Christoph.Pleger@uni-dortmund.de> <42E0B6E4.1030303@pobox.com> <20050722113138.5d81c770.Christoph.Pleger@uni-dortmund.de> <20050722103955.GI30510@unthought.net> <20050722133746.67e5f5d3.Christoph.Pleger@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722133746.67e5f5d3.Christoph.Pleger@uni-dortmund.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 01:37:46PM +0200, Christoph Pleger wrote:
> Hello,
> 
...
> I am also using Debian sarge. I extracted the tarfile to /usr/local/bin
> end executed "kmake menuconfig". Everything seemed fine so far. But a
> few seconds after starting the compilation (kmake bzImage) I got this
> error message:
> 
> In file included from <snip>
> ...
> <snip>
> include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory

Try a plain 2.6.11.11

> Hm. I understand why that file cannot be found: It only exists in the
> asm-i386 directory. But why does the compilation process look for a file
> that belongs to i386, but not to x86_64?

Kernel source screwed up?  :)

-- 

 / jakob

