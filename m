Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWH2Bc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWH2Bc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWH2Bc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:32:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:57282 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750914AbWH2Bcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:32:55 -0400
Date: Mon, 28 Aug 2006 18:31:37 -0700
From: Greg KH <greg@kroah.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Fernando Vazquez <fernando@oss.ntt.co.jp>, gregkh@suse.de, akpm@osdl.org,
       dev@openvz.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net, stable@kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com, xemul@openvz.org
Subject: Re: [stable] [PATCH] Linux 2.6.17.11 - fix compilation error on IA64 (try #3)
Message-ID: <20060829013137.GA27869@kroah.com>
References: <617E1C2C70743745A92448908E030B2A72869D@scsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617E1C2C70743745A92448908E030B2A72869D@scsmsx411.amr.corp.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 03:11:31PM -0700, Luck, Tony wrote:
> > The commit 8833ebaa3f4325820fe3338ccf6fae04f6669254 introduced a change that broke 
> > IA64 compilation as shown below:
> 
> What happened to the mainline version of the patch to which this
> is a fix (local DoS with corrupted ELFs)?  I don't see it in 2.6.18-rc5.
> Did it get fixed some other way, or is it just queued somewhere?  Or do
> we have a fix in -stable that isn't in mainline?

I thought this was a fix for a prior -stable patch that did not affect
mainline.  Or was this thought wrong?

thanks,

greg k-h
