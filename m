Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269224AbTCBOoz>; Sun, 2 Mar 2003 09:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269225AbTCBOoz>; Sun, 2 Mar 2003 09:44:55 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:15530 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S269224AbTCBOoz>; Sun, 2 Mar 2003 09:44:55 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: Dan Kegel <dank@kegel.com>, Matthias Schniedermeyer <ms@citd.de>,
       Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
In-Reply-To: <1046612993.7527.472.camel@spc1.mesatop.com>
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>
	 <3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com>
	 <3E6167B1.6040206@kegel.com>  <3E617428.3090207@kegel.com>
	 <1046578585.2544.451.camel@spc1.mesatop.com>
	 <1046604117.12947.16.camel@imladris.demon.co.uk>
	 <1046612993.7527.472.camel@spc1.mesatop.com>
Organization: 
Message-Id: <1046616908.12947.27.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 02 Mar 2003 14:55:08 +0000
Subject: Re: [PATCH] kernel source spellchecker
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 13:49, Steven Cole wrote:

> > It might also be worth adding a list of 'suspect' spellings -- which
> > require human intervention.

> In my first pass through the tree, it looks like there are quite a few
> _correct_ uses of errata, but there indeed some of these:
> 
> ./drivers/net/tulip/de2104x.c:  /* Avoid a chip errata by prefixing a dummy entry. */
> 
> I think the errata/erratum issue requires careful editing.

Indeed -- that's my point. It's 'suspect' but not necessarily wrong.
Likewise 'indexes' which can be permissible too, when used as a verb,
but is more likely to just be a thinko for 'indices'.

-- 
dwmw2

