Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967471AbWK2ROa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967471AbWK2ROa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 12:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967482AbWK2ROa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 12:14:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1940 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S967471AbWK2RO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 12:14:29 -0500
Subject: Re: [PATCH] UBI
From: David Woodhouse <dwmw2@infradead.org>
To: dedekind@infradead.org
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, haver@vnet.ibm.com,
       Josh Boyer <jwboyer@linux.vnet.ibm.com>, arnez@vnet.ibm.com,
       linux-mtd@mgw-ext13.nokia.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164819769.576.53.camel@sauron>
References: <1164819769.576.53.camel@sauron>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 17:12:23 +0000
Message-Id: <1164820343.14595.104.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 19:02 +0200, Artem Bityutskiy wrote:
> Hello Andrew,
> 
> we have announced UBI several months ago in the MTD mailing list. It was
> successfully used in our setup and we've got positive feedback.
> 
> In short, it is kind of LVM layer but for flash (MTD) devices which
> hides flash devices complexities like bad eraseblocks (on NANDs) and
> wear. The documentation is available at the MTD web site:
> http://www.linux-mtd.infradead.org/doc/ubi.html
> http://www.linux-mtd.infradead.org/faq/ubi.html
> 
> The source code is available at the UBI GIT tree:
> git://git.infradead.org/home/dedekind/ubi-2.6.git

Make that git://git.infradead.org/~dedekind/ubi-2.6.git
or http://git.infradead.org/?p=users/dedekind/ubi-2.6.git

And it would be helpful (at least to me) if you'd keep an 'mtd' or
'linus' branch in your tree, which shows the point at which you last
pulled from your upstream tree(s). That way, 'git-diff mtd..' or
'gitk mtd..' work.

-- 
dwmw2

