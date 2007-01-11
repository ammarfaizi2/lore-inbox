Return-Path: <linux-kernel-owner+w=401wt.eu-S965133AbXAKOiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbXAKOiT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965359AbXAKOiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:38:19 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2304 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965133AbXAKOiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:38:19 -0500
Date: Thu, 11 Jan 2007 15:38:15 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI mmconfig support for Intel 915 bridges
Message-ID: <20070111143815.GA3254@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200701101853.04059.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701101853.04059.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 06:53:03PM -0800, Jesse Barnes wrote:
> This is a resend of the patch I sent earlier to Oliver.  It adds support
> for Intel 915 bridge chips to the new PCI MMConfig detection code.  Tested
> and works on my sole 915 based platform (a Toshiba laptop).  I added
> register masking per Oliver's suggestion, and moved the __init qualifier to
> after the 'static const char' to match Ogawa-san's recent cleanup patches.
> 
> Over time we can probably associate more PCI IDs with this routine, since
> i915 family contains a few other chips.  But since I didn't have platforms
> to test such additions on, they're left out for now.
> 
> Signed-off-by:  Jesse Barnes <jbarnes@virtuousgeek.org>

Signed-off-by: Olivier Galibert <galibert@pobox.com>

Andrew, you sent me a series of emails to tell me the patches had
moved to another subsystem tree, can you tell me which one?  There is
at least an anti-regression patch to add on top (the Asus/Nvidia
special case is causing oopses right now).

  OG.

