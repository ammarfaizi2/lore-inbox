Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbTEKM4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTEKM4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:56:24 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:15232
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261315AbTEKM4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:56:22 -0400
Date: Sun, 11 May 2003 08:58:57 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Jos Hulzink <josh@stack.nl>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: irq balancing: performance disaster
In-Reply-To: <20030511125438.GJ8978@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0305110855120.15337-100000@montezuma.mastecende.com>
References: <200305110118.10136.josh@stack.nl> <7750000.1052619248@[10.10.2.4]>
 <200305111200.31242.josh@stack.nl> <Pine.LNX.4.50.0305110813140.15337-100000@montezuma.mastecende.com>
 <20030511125438.GJ8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, William Lee Irwin III wrote:

> On Sun, May 11, 2003 at 08:17:53AM -0400, Zwane Mwaikambo wrote:
> > It was a bug in 2.4, fixed in Alan's tree by setting target_cpus to 0xff 
> > (previously cpu_online_map). There is no noirqbalance option in 2.4 
> > because there is no in kernel irq balancer.
> 
> I vaguely like this notion because it removes a #ifdef and cleans up
> a tiny bit of its surroundings. But it's not quite a one-liner.

Nice, it's during init too so there really is no need for any sort of 
optimisation, the inline can also go and make it __init.

	Zwane

-- 
function.linuxpower.ca
