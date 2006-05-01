Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWEAVGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWEAVGv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWEAVGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:06:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20161 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750801AbWEAVGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:06:50 -0400
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jiri Slaby <jirislaby@gmail.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0605012300080.782@yvahk01.tjqt.qr>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
	 <Pine.LNX.4.61.0605011559010.31804@yvahk01.tjqt.qr>
	 <1146502730.2885.128.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.61.0605012219560.32033@yvahk01.tjqt.qr>
	 <4456732B.2090009@gmail.com>
	 <Pine.LNX.4.61.0605012300080.782@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Mon, 01 May 2006 22:07:29 +0100
Message-Id: <1146517650.1921.55.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 23:01 +0200, Jan Engelhardt wrote:
>   find rc3 -type f -print0 | xargs -0 perl -i -pe
>     's/\btask_t\b/struct task_struct'
> 
> + a compile test afterwards. Something I missed? (Besides that lines
> may get longer and violate the 80-column CodingStyle rule.) 

If we're going to do that, we might as well make it 'struct task'. The
additional '_struct' is redundant.

-- 
dwmw2

