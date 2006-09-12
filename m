Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWILQWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWILQWj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 12:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWILQWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 12:22:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32666 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030277AbWILQWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 12:22:38 -0400
Date: Tue, 12 Sep 2006 12:29:29 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quirks: Flag up and handle the AMD 8151 Errata #24
Message-ID: <20060912162929.GA6961@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <1158078540.6780.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158078540.6780.61.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 05:29:00PM +0100, Alan Cox wrote:
 > +		printk(KERN_INFO "Disabling direct PCI/AGP transfers.\n");

Can we add the reason here too? I get quite a lot of bizarre emails already
because someone read "AGP" somewhere so it's obviously my fault..

Something along the lines of
"CPU errata detected: Disabling direct PCI/AGP transfers.\n"

perhaps ?

	Dave
