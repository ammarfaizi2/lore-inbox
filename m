Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVCOLGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVCOLGy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 06:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVCOLGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 06:06:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23986 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261716AbVCOLGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 06:06:48 -0500
Subject: Re: nvidia fb licensing issue.
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Jon Smirl <jonsmirl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       adaplas@pol.net
In-Reply-To: <Pine.LNX.4.58.0503151028160.22756@skynet>
References: <20050313042459.GF32494@redhat.com>
	 <20050312215936.513039a6.akpm@osdl.org>
	 <1110701914.6278.18.camel@laptopd505.fenrus.org>
	 <9e47339105031318038d74da9@mail.gmail.com>
	 <Pine.LNX.4.58.0503151028160.22756@skynet>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 12:06:38 +0100
Message-Id: <1110884798.6290.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 10:32 +0000, Dave Airlie wrote:
> On Sun, 13 Mar 2005, Jon Smirl wrote:
> 
> > All of the files in drivers/char/drm really should have an explicit
> > dual MIT/GPL license on them too. The DRM project has been taking
> > patches back into DRM from LKML without making it clear that DRM is
> > MIT licensed. It might be construed that doing this has made DRM GPL
> > without that being the intention.
> 
> They all have explicit MIT licenses on them, these files are only
> dual-licensed by the fact that they are shipped with the kernel, but they
> are MIT licensed and I would consider any changes to them to be MIT
> licensed unless someone explicitly states it..

this is actually a bit of a legal iffy point here. People submit patches
to the kernel (which is GPL). In addition, while patches to gpl code are
gpl (by the gpl "derived works" clause), the MIT license has no such
requirement or even assumption on derived works so it's all quite iffy.
I strongly suggest you put the dual license header in those files to get
rid of the ambiguity..  as you said it's not really a big deal in that
the code already is dual licensed in effect; please consider making it
explicit, it solves a lot of ambiguity.


