Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbUCDEN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUCDEKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:10:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:46261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261431AbUCDEHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:07:08 -0500
Date: Wed, 3 Mar 2004 20:07:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Zaitsev <peter@mysql.com>
Cc: andrea@suse.de, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040303200704.17d81bda.akpm@osdl.org>
In-Reply-To: <1078371876.3403.810.camel@abyss.local>
References: <20040228072926.GR8834@dualathlon.random>
	<Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
	<20040229014357.GW8834@dualathlon.random>
	<1078370073.3403.759.camel@abyss.local>
	<20040303193343.52226603.akpm@osdl.org>
	<1078371876.3403.810.camel@abyss.local>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev <peter@mysql.com> wrote:
>
> Sorry if I was unclear.  These are suffexes from RH AS 3.0 kernel
>  namings.  "SMP" corresponds to normal SMP kernel they have,  "hugemem"
>  is kernel with 4G/4G split.
> 
>  > 
>  > > For CPU bound load (10 Warehouses) I got 7000TPM instead of 4500TPM,
>  > > which is over 35% slowdown.
>  > 
>  > Well no, it is a 56% speedup.   Please clarify.  Lots.
> 
>  Huh. The numbers shall be other way around of course :)   "smp" kernel
>  had better performance of some 7000TPM, compared to  4500TPM with
>  HugeMem kernel. 

That's a larger difference than I expected.  But then, everyone has been
mysteriously quiet with the 4g/4g benchmarking.

A kernel profile would be interesting.  As would an optimisation effort,
which, as far as I know, has never been undertaken.

