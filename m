Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVCNGxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVCNGxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 01:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVCNGxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 01:53:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43670 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261204AbVCNGxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 01:53:48 -0500
Subject: Re: nvidia fb licensing issue.
From: Arjan van de Ven <arjan@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       adaplas@pol.net
In-Reply-To: <9e47339105031318038d74da9@mail.gmail.com>
References: <20050313042459.GF32494@redhat.com>
	 <20050312215936.513039a6.akpm@osdl.org>
	 <1110701914.6278.18.camel@laptopd505.fenrus.org>
	 <9e47339105031318038d74da9@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 07:53:39 +0100
Message-Id: <1110783219.6288.27.camel@laptopd505.fenrus.org>
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

On Sun, 2005-03-13 at 21:03 -0500, Jon Smirl wrote:
> All of the files in drivers/char/drm really should have an explicit
> dual MIT/GPL license on them too. The DRM project has been taking
> patches back into DRM from LKML without making it clear that DRM is
> MIT licensed. It might be construed that doing this has made DRM GPL
> without that being the intention.

without explicit dual licensing this is a trap yeah... it's far far
nicer to just make it explicit that it's dual licensed and that you
expect all patches are also dual licensed unless they also remove one of
the licenses (several dual licensed parts of the kernel have such
language if you're looking for example text). Otherwise its very much an
unclear situation and with licenses it's just better to be very explicit
and clear.


