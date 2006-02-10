Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWBJQde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWBJQde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWBJQde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:33:34 -0500
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:12749 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751287AbWBJQdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:33:32 -0500
Date: Fri, 10 Feb 2006 17:34:07 +0100
From: Mattia Dongili <malattia@linux.it>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] fbdev: Fix typo in fbmem.c
Message-ID: <20060210163407.GA3531@inferi.kami.home>
Mail-Followup-To: "Antonino A. Daplas" <adaplas@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20060207220627.345107c3.akpm@osdl.org> <20060210145243.GA3581@inferi.kami.home> <43ECADBC.2080107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ECADBC.2080107@gmail.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc2-mm1-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 11:14:04PM +0800, Antonino A. Daplas wrote:
> A typo in fbmem.c prevents recognition of video= parameter.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> 
> ---
> Mattia Dongili wrote:
> 
> > On Tue, Feb 07, 2006 at 10:06:27PM -0800, Andrew Morton wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/
> > 
> > Hello,
> > 
> > radeonfb ignores the video= parameter and always run at 1400x1050 (the
> > highest available). Things where fine with .16-rc1-mm5.
> > I also tried booting with 640x480-32@60 without success.
> 
> Try this patch.

Thanks, now working as usual. (BTW: my ISP smtp is blacklisted so my
messages won't reach linux-fbdev-devel)

ciao
-- 
mattia
:wq!
