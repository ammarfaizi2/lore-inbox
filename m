Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWE3TNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWE3TNt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWE3TNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:13:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37854 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932370AbWE3TNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:13:48 -0400
Subject: Re: 2.6.17-rc5-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0605300546k26090790s54581ca16855de2d@mail.gmail.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605300546k26090790s54581ca16855de2d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 21:13:43 +0200
Message-Id: <1149016423.3636.95.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 14:46 +0200, Michal Piotrowski wrote:
> Hi,
> 
> On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> >
> 
> ============================
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {in-hardirq-W} -> {hardirq-on-W} usage.
> udevd/415 [HC0[0]:SC1[1]:HE1:SE0] takes:
>  (&base->lock#2){++..}, at: [<c012900a>] run_timer_softirq+0x3d/0x164

hhmmm curious.. you don't happen to have nmi watchdog enabled??

