Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTKYBVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 20:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTKYBVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 20:21:05 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:6084 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261873AbTKYBVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 20:21:03 -0500
Date: Mon, 24 Nov 2003 20:19:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: OOps! was: 2.6.0-test9-mm5
In-Reply-To: <20031125003658.GA1342@mis-mike-wstn.matchmail.com>
Message-ID: <Pine.LNX.4.58.0311242013270.1859@montezuma.fsmlabs.com>
References: <20031121121116.61db0160.akpm@osdl.org>
 <20031124225527.GB1343@mis-mike-wstn.matchmail.com>
 <Pine.LNX.4.58.0311241840380.8180@montezuma.fsmlabs.com>
 <20031124235807.GA1586@mis-mike-wstn.matchmail.com>
 <20031125003658.GA1342@mis-mike-wstn.matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Mike Fedyk wrote:

> On Mon, Nov 24, 2003 at 03:58:07PM -0800, Mike Fedyk wrote:
> > I just compiled witout preempt and it still gives an oops at the same spot.
>
> Just compiled vanilla 2.6.0-test9 and it doesn't oops.
>
> Let me know if you still want me to hand type that oops.

Try disabling CONFIG_PNPBIOS and if that fixes it, try backing out one by
one;

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm5/broken-out/pnp-fix-[1234].patch

But yes, the oops transcribed would be nice.

