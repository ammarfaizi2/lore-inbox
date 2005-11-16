Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVKPFuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVKPFuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 00:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbVKPFuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 00:50:00 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:61601 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S932591AbVKPFt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 00:49:59 -0500
Message-ID: <20051116064938.rrezbal2pv4s0088@webmail.ens-lyon.fr>
Date: Wed, 16 Nov 2005 06:49:38 +0100
From: abuisse@ens-lyon.fr
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com, zilvinas@gemtek.lt
Subject: Re: Linuv 2.6.15-rc1
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org>
In-Reply-To: <20051114162942.5b163558.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@osdl.org>:
>
> This looks like some sort of slab scribble, possibly caused by faulty
> error-path handling in the ipw2200 code.
>
> Please enable CONFIG_DEBUG_SLAB and see if that picks anything up.
>
> Also enable CONFIG_DEBUG_PAGEALLOC.
>
> You may also get more info by setting CONFIG_IPW_DEBUG and loading the
> module with `debug=65535' (guess).
>
> Whatever you do, don't fix the firmware loading failure (sorry).  Doing
> that will cause you to not be able to reproduce this bug ;)

Hi,

I enabled all these options yesterday and ran it all night without 
encountering
this oops again (the firmware loading error yes, but I've had it since I began
to use ipw2200). Perhaps isn't it the same issue than Zilvinas ?
I'll continue trying, though...

Regards,
Alexandre

