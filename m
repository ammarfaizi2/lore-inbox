Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVACPUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVACPUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 10:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVACPUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 10:20:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63900 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261470AbVACPUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 10:20:01 -0500
Date: Mon, 3 Jan 2005 10:18:47 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andries Brouwer <aebr@win.tue.nl>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <20050102212427.GG2818@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
 <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jan 2005, Andries Brouwer wrote:

> You change some stuff. The bad mistakes are discovered very soon.
> Some subtler things or some things that occur only in special
> configurations or under special conditions or just with
> very low probability may not be noticed until much later.

Some of these subtle bugs are only discovered a year
after the distribution with some particular kernel has
been deployed - at which point the kernel has moved on
so far that the fix the distro does might no longer
apply (even in concept) to the upstream kernel...

This is especially true when you are talking about really
big database servers and bugs that take weeks or months
to trigger.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
