Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269632AbUICM07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269632AbUICM07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269658AbUICM07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:26:59 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:39685 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269632AbUICMZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:25:45 -0400
Date: Fri, 3 Sep 2004 13:25:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, takata@linux-m32r.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm3
Message-ID: <20040903132537.A4132@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Andrew Morton <akpm@osdl.org>, takata@linux-m32r.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903104239.A3077@infradead.org> <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>; from zwane@linuxpower.ca on Fri, Sep 03, 2004 at 08:15:29AM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 08:15:29AM -0400, Zwane Mwaikambo wrote:
> On Fri, 3 Sep 2004, Christoph Hellwig wrote:
> 
> > On Fri, Sep 03, 2004 at 01:48:11AM -0700, Andrew Morton wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm3/
> > >
> > > - Added the m32r architecture.  Haven't looked at it yet.
> >
> > Just from looking at the diffstat and not actual code: the actual code:
> >
> >  - it adds new drivers under arch/m32r instead of drivers/
> 
> Lucky you didn't look ;)
> 
> diff -puN /dev/null arch/m32r/drivers/8390.c
> --- /dev/null	Thu Apr 11 07:25:15 2002
> +++ 25-akpm/arch/m32r/drivers/8390.c	Wed Sep  1 15:02:27 2004
> @@ -0,0 +1 @@
> +#include "../../../drivers/net/8390.c"

which is even worse.  Also the smc driver duplicates one already under
drivers/net/

