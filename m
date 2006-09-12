Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWILWku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWILWku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWILWku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:40:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20119 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932302AbWILWkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:40:49 -0400
Subject: Re: [PATCH] quirks: Flag up and handle the AMD 8151 Errata #24
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ak@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060912162929.GA6961@redhat.com>
References: <1158078540.6780.61.camel@localhost.localdomain>
	 <20060912162929.GA6961@redhat.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 23:39:51 +0100
Message-Id: <1158100791.18619.107.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 12:29 -0400, Dave Jones wrote:
> On Tue, Sep 12, 2006 at 05:29:00PM +0100, Alan Cox wrote:
>  > +		printk(KERN_INFO "Disabling direct PCI/AGP transfers.\n");
> 
> Can we add the reason here too? I get quite a lot of bizarre emails already
> because someone read "AGP" somewhere so it's obviously my fault..
> 
> Something along the lines of
> "CPU errata detected: Disabling direct PCI/AGP transfers.\n"

Especially when it's user-visible, please make sure you spell 'erratum'
correctly.

-- 
dwmw2

