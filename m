Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVGDHTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVGDHTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 03:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVGDHTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 03:19:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59097 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261568AbVGDHM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 03:12:56 -0400
Subject: Re: [PATCH] drm: remove drm_calloc()
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, David Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <21d7e99705070323334a194b47@mail.gmail.com>
References: <200507041026.52631.adobriyan@gmail.com>
	 <21d7e99705070323334a194b47@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 04 Jul 2005 09:12:47 +0200
Message-Id: <1120461167.3174.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Mon, 2005-07-04 at 16:33 +1000, Dave Airlie wrote:
> The DRM has wrappers for these function due to it being used on other
> OS'es (BSD mainly)

yes and? how about naming that wrapper "kcalloc()" instead.... which
would make the linux "wrapper" empty and the bsd wrapper just trivial
las well ?




