Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbUKCTVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbUKCTVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbUKCTVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:21:20 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:41355 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261817AbUKCTUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:20:39 -0500
Date: Wed, 3 Nov 2004 11:20:27 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
Message-ID: <20041103192027.GA25543@taniwha.stupidest.org>
References: <20041103091039.GA22469@taniwha.stupidest.org> <41891980.6040009@pobox.com> <20041103190757.GA25451@taniwha.stupidest.org> <41892DE3.5040402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41892DE3.5040402@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:13:39PM -0500, Jeff Garzik wrote:

> There is a 2.4 version of module_param().

2.4 what?

> The semantics of pci_module_init() versus pci_register_driver() are
> different across 2.4/2.6.

I actually didn't realize this... (in truth I didn't think about it).
Is this explained anywhere?

> If you deprecate pci_module_init(), you are breaking drivers which
> right now can be ported to 2.4 with a simple cp(1).

> It's just downright silly to deprecate the API that is used most
> heavily in drivers.

Sure, I'll buy that.
