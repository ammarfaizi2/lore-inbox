Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750720AbWFEWNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWFEWNS (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWFEWNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:13:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61599 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750720AbWFEWNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:13:17 -0400
Date: Mon, 5 Jun 2006 15:12:20 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: mbligh@google.com, apw@shadowen.org, mbligh@mbligh.org,
        linux-kernel@vger.kernel.org, ak@suse.de, hugh@veritas.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <20060605135812.30138205.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606051510320.19228@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <44848DD2.7010506@shadowen.org> <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
 <20060605135812.30138205.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006, Andrew Morton wrote:

> Thanks, Christoph.  So we get to keep the crappy test?

Well at least as long as we have not established that it is not needed.
 
> I wonder what LTP was corrupting before it started to corrupt page
> migration data?

Whatever came after the swap_info array. What does the System map say on 
that platform?

> The above looks like a 2.6.17 thing to me.

Right.
