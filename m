Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVAUGJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVAUGJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVAUGJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:09:39 -0500
Received: from waste.org ([216.27.176.166]:15524 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262262AbVAUGJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:09:36 -0500
Date: Thu, 20 Jan 2005 22:09:28 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       benh@kernel.crashing.org
Subject: Re: Radeon framebuffer weirdness in -mm2
Message-ID: <20050121060928.GI12076@waste.org>
References: <20050120232122.GF3867@waste.org> <20050120153921.11d7c4fa.akpm@osdl.org> <20050120234844.GF12076@waste.org> <20050120160123.14f13ca6.akpm@osdl.org> <20050121035758.GH12076@waste.org> <20050120200530.4d5871f9.akpm@osdl.org> <20050120200711.4313dbcc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120200711.4313dbcc.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 08:07:11PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Next suspects would be:
> > 
> >  +cleanup-vc-array-access.patch
> >  +remove-console_macrosh.patch
> >  +merge-vt_struct-into-vc_data.patch
> > 
> > 
> 
> Make that:
> 
> +cleanup-vc-array-access.patch
> +remove-console_macrosh.patch
> +merge-vt_struct-into-vc_data.patch
> +vgacon-fixes-to-help-font-restauration-in-x11.patch

It's something in this batch. Which is good, as I'd be a bit
disappointed if the "vt leakage" were somehow attributable to the fb
layer. More bisection after dinner.

-- 
Mathematics is the supreme nostalgia of our time.
