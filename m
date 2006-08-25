Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422835AbWHYEUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422835AbWHYEUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 00:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422836AbWHYEUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 00:20:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:15756 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422835AbWHYEUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 00:20:15 -0400
Date: Thu, 24 Aug 2006 21:20:03 -0700
From: Greg KH <gregkh@suse.de>
To: Jeremy Roberson <jroberson@gtcocalcomp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH  2.6.9-34.0.1.EL] hid-core.c: Add GTCO CalComp PIDs to blacklist
Message-ID: <20060825042003.GA20946@suse.de>
References: <1156463012.32020.63.camel@FC3Dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156463012.32020.63.camel@FC3Dev>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:43:32PM -0700, Jeremy Roberson wrote:
> This patch adds all of the PIDs for our company's Digitizers and
> Interactive School products to hid-core.c

For the 2.6.9 kernel?  What about generating a patch for the latest
kernel version?

And you can do this a bit more simply, if you just want to disable all
devices from a specific manufacturer.  Look at the Watcom change that
does this in the current -mm tree.

Also, what driver will control these devices if the hid core does not?
Is it a userspace driver or a kernel one?

thanks,

greg k-h
