Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263078AbUJ2D65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbUJ2D65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 23:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUJ2D65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 23:58:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:33211 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263078AbUJ2D64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 23:58:56 -0400
Date: Fri, 29 Oct 2004 05:57:26 +0200
From: Andi Kleen <ak@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: slab errors
Message-ID: <20041029035726.GJ11384@wotan.suse.de>
References: <20041028091204.GB1618@wotan.suse.de> <41812D09.4060601@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41812D09.4060601@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 07:31:53PM +0200, Manfred Spraul wrote:
> Andi Kleen wrote:
> 
> >Hi,
> >
> >I get this when booting 2.6.10rc1-bk6 on x86-64. slab doesn't seem
> >to like its own initialization.
> >
> > 
> >
> I'm not aware of any slab changes. Were there any changes to the memset 
> function? I think slab debug is the only codepath that uses memset to 
> nonzero values.

Indeed it was a buggy memset patch again (sigh). Sorry for the noise.
I dropped it now.

-Andi
