Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWAGIeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWAGIeX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 03:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWAGIeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 03:34:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61319 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030359AbWAGIeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 03:34:21 -0500
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20060106223311.134d76d4.akpm@osdl.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	 <1136544309.2940.25.camel@laptopd505.fenrus.org>
	 <43BEA970.4050704@pobox.com>
	 <1136576160.2940.76.camel@laptopd505.fenrus.org>
	 <20060106223311.134d76d4.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 09:34:15 +0100
Message-Id: <1136622855.2936.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 22:33 -0800, Andrew Morton wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > if optimizing for size (CONFIG_CC_OPTIMIZE_FOR_SIZE), allow gcc4 compilers
> >  to decide what to inline and what not - instead of the kernel forcing gcc
> >  to inline all the time. This requires several places that require to be 
> >  inlined to be marked as such, previous patches in this series do that.
> 
> This one stomps all over more-updates-for-the-gcc-=-32-requirement.patch. 
> PLease redo against 2.6.15-mm1 or next -mm?

Will do.


