Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbVEIBix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbVEIBix (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 21:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVEIBix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 21:38:53 -0400
Received: from colin.muc.de ([193.149.48.1]:52239 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S263022AbVEIBiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 21:38:52 -0400
Date: 9 May 2005 03:38:51 +0200
Date: Mon, 9 May 2005 03:38:51 +0200
From: Andi Kleen <ak@muc.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc3-mm3] perfctr: x86 update with K8 multicore fixes
Message-ID: <20050509013851.GA54090@muc.de>
References: <200505090040.j490e19v012839@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505090040.j490e19v012839@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 02:40:01AM +0200, Mikael Pettersson wrote:
> > How about you just check cpu_core_map[] instead of adding your
> > own custom detection code for this? This seems quite bogus to me.
> 
> Because these <whatever>map[]s are poorly documented, change
> (get added or removed), and don't always exist in all subarchs.

That's all not true. 

> I've been burned by cpu-related maps changing before. I'd rather
> not rely on them if I can avoid them.

I don't think that's a good attitude for a in tree driver. 
If all drivers reimplemented core architecture features
all the time we would have a big mess. So please don't do
this.

-Andi
