Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUGGGFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUGGGFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 02:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbUGGGFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 02:05:33 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:51321 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264917AbUGGGF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 02:05:27 -0400
Subject: Re: [PATCH] fix tcp_default_win_scale.
From: Redeeman <lkml@metanurb.dk>
To: bert hubert <ahu@ds9a.nl>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1089178782.10677.0.camel@localhost>
References: <32886.63.170.215.71.1088564087.squirrel@www.osdl.org>
	 <20040629222751.392f0a82.davem@redhat.com>
	 <20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>
	 <20040630153049.3ca25b76.davem@redhat.com>
	 <20040701133738.301b9e46@dell_ss3.pdx.osdl.net>
	 <20040701140406.62dfbc2a.davem@redhat.com>
	 <20040702013225.GA24707@conectiva.com.br>
	 <20040706093503.GA8147@outpost.ds9a.nl>
	 <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
	 <1089155965.15544.9.camel@localhost>
	 <20040706232538.GA8054@outpost.ds9a.nl>
	 <1089178782.10677.0.camel@localhost>
Content-Type: text/plain
Date: Wed, 07 Jul 2004 08:05:26 +0200
Message-Id: <1089180326.10677.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i just got some ideas to test.. i will report back in some days
On Wed, 2004-07-07 at 07:39 +0200, Redeeman wrote:
> damn, just tested this patch, it does not fix my issues. i wish there
> were a way to just get it like it was on 2.6.5
> 
> On Wed, 2004-07-07 at 01:25 +0200, bert hubert wrote:
> > On Wed, Jul 07, 2004 at 01:19:25AM +0200, Redeeman wrote:
> > 
> > > so this should fix the issues? can you also tell me why this suddenly happend? that would make me a real happy man
> > 
> > It appears older linux kernels would announce window scaling capability, but
> > not in fact scale their windows themselves, thus hiding the problem.
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

