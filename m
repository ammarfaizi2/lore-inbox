Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752180AbWIXH3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbWIXH3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 03:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbWIXH3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 03:29:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53162 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752180AbWIXH3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 03:29:48 -0400
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
From: David Woodhouse <dwmw2@infradead.org>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: linux-kernel@vger.kernel.org, luke Yang <luke.adi@gmail.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <6.1.1.1.0.20060923191145.01eced00@ptg1.spd.analog.com>
References: <6.1.1.1.0.20060923191145.01eced00@ptg1.spd.analog.com>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 08:29:14 +0100
Message-Id: <1159082954.24527.942.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-23 at 19:25 -0400, Robin Getz wrote:
> >On Thu, 2006-09-21 at 11:32 +0800, Luke Yang wrote:
> > >   This is the blackfin architecture for 2.6.18, again.
> >
> >Please run 'make headers_check' for blackfin and then verify that you can 
> >build libc against the resulting headers.
> 
> We can't build libc, but we can build uClibc ;)

That's why I said 'libc' and not 'glibc'.

> This is how we build our toolchain today (mostly). - now we do a make 
> prepare, but we will update it.

I don't believe you provided a Kbuild file for your architecture --
without which 'make headers_install' and 'make headers_check' aren't
going to work.

-- 
dwmw2

