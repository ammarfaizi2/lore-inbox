Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVL0FSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVL0FSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 00:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVL0FSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 00:18:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:35082 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932229AbVL0FSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 00:18:13 -0500
Date: Tue, 27 Dec 2005 06:17:29 +0100
From: Willy Tarreau <willy@w.ods.org>
To: gcoady@gmail.com
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org
Subject: Re: Linux 2.6.14.5
Message-ID: <20051227051729.GR15993@alpha.home.local>
References: <20051227005327.GA21786@kroah.com> <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 02:06:03PM +1100, Grant Coady wrote:
> On Mon, 26 Dec 2005 16:53:27 -0800, Greg KH <gregkh@suse.de> wrote:
> 
> >We (the -stable team) are announcing the release of the 2.6.14.5 kernel.
> >
> >The diffstat and short summary of the fixes are below.
> >
> >I'll also be replying to this message with a copy of the patch between
> >2.6.14.4 and 2.6.14.5, as it is small enough to do so.
> 
> netfilter is broken compared to 2.6.15-rc7 (first 2.6 kernel tested 
> on this box) or 2.4.32 :(  Same ruleset as used for months.
> 
> Fails to recognise named chains with a useless error message:
> 
> "iptables: No chain/target/match by that name"

Grant, please put a "set -x" at the top of your script so that you
can tell what rule causes this error.

> Grant.

Thanks,
Willy

