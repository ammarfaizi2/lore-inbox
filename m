Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVG1PTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVG1PTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVG1PRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:17:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40651 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261554AbVG1PQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:16:45 -0400
Date: Thu, 28 Jul 2005 16:16:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] compat_sys_read/write
Message-ID: <20050728151641.GA23692@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20050728234341.3303d5fe.sfr@canb.auug.org.au> <20050728141653.GA22173@infradead.org> <20050729004838.116e8361.sfr@canb.auug.org.au> <20050728150258.GA22472@infradead.org> <20050729011307.01a2d64e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729011307.01a2d64e.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 01:13:07AM +1000, Stephen Rothwell wrote:
> On Thu, 28 Jul 2005 16:02:58 +0100 Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > And where were you a week ago when I asked if I should post this patch? 
> > 
> > A :-) Can't remember it at all, maybe you forgot that we mere mortals can't
> > read linux-arch@vger.kernel.org ?
> 
> Sorry about that, my omniscience must be slipping :-)
> 
> Anyway, here is the alternative I offered that was rejected by some (hi Andi :-))
> and not particularly like by others ... (without the actual evdev.c fix)
> 
> Is this any more palatable to the wider community?

Make it out of line, EXPORT_SYMBOL_GPL and add a big warning about it?
So we don't get new users introduced easily and without a very good reason.

