Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVFAMkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVFAMkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVFAMkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:40:39 -0400
Received: from unthought.net ([212.97.129.88]:53725 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261373AbVFAMk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:40:26 -0400
Date: Wed, 1 Jun 2005 14:40:25 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: david.balazic@hermes.si
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
Message-ID: <20050601124025.GZ422@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	david.balazic@hermes.si, linux-kernel@vger.kernel.org
References: <200506011225.j51CPDV23243@lastovo.hermes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506011225.j51CPDV23243@lastovo.hermes.si>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 02:25:13PM +0200, david.balazic@hermes.si wrote:
> Hi! 
> 
> Is there any doc about swap size limits ? 

Documetation?  Is this a trick question?  It's Linux, of course there is
no current documentation except for the source  ;)

 /me ducks and runs   ;)

> The mkwap(8) man page claims, that currently the limit is 
> 32 swap areas of maximum 2 gigabyte size (for x86 arch). 
> 
> Is that correct ? 

Not on 2.6 kernels, no.

[sparrow:joe] $ cat /proc/swaps
Filename                 Type            Size    Used Priority
/dev/mapper/vg0-swap     partition       8388600 0    -1

I use 4-8 G swap areas on 32-bit x86 and 64-bit amd64 kernels.

You probably need a new version of mkswap if it insists that 2G is the
maximum - it sure isn't a kernel limitation anymore.

-- 

 / jakob

