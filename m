Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWILQ3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWILQ3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 12:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWILQ3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 12:29:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16866 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965148AbWILQ3p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 12:29:45 -0400
Subject: Re: [PATCH] quirks: Flag up and handle the AMD 8151 Errata #24
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060912162929.GA6961@redhat.com>
References: <1158078540.6780.61.camel@localhost.localdomain>
	 <20060912162929.GA6961@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 17:52:54 +0100
Message-Id: <1158079974.6780.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-12 am 12:29 -0400, ysgrifennodd Dave Jones:
> On Tue, Sep 12, 2006 at 05:29:00PM +0100, Alan Cox wrote:
>  > +		printk(KERN_INFO "Disabling direct PCI/AGP transfers.\n");
> 
> Can we add the reason here too? I get quite a lot of bizarre emails already
> because someone read "AGP" somewhere so it's obviously my fault..
> 
> Something along the lines of
> "CPU errata detected: Disabling direct PCI/AGP transfers.\n"

Chipset errata in this case but yes sure. I'll send an update to the
change if its accepted/merged and nothing else needs fixing on it.

I'm sure it is your fault really though 8)

Alan
