Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVADWOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVADWOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVADWKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:10:09 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:35597 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261832AbVADWIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:08:39 -0500
Date: Tue, 4 Jan 2005 23:03:13 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marek Habersack <grendel@caudium.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
Message-ID: <20050104220313.GD7048@alpha.home.local>
References: <20050104195636.GA23034@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104195636.GA23034@beowulf.thanes.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 04, 2005 at 08:56:36PM +0100, Marek Habersack wrote:
(...) 
> equipped with 2.6Ghz P4 CPUs, 1Gb of ram, 2-4gb of swap, the kernel config
> is attached. The machines have normal load averages hovering not higher than
> 7.0, depending on the time of the day etc. Two of the machines run 2.4.25,
> one 2.4.27 and they work fine. When booted with 2.4.28, though (compiled
> with Debian's gcc 2.3.5, with p3 or p4 CPU selected in the config), the load
> is climbing very fast and hovers around a value 3-4 times higher than with
> the older kernels. Booted back in the old kernel, the load comes to its
> usual level. The logs suggest nothing, no errors, nothing unusual is
> happening. 
> 
> Has anyone had similar problems with 2.4.28 in an environment resembling the
> above? Could it be a problem with highmem i/o?
 
Never encountered yet ! Could you provide some indications about the type of
work (I/O, network, CPU, scripts execution, #of processes, etc...) ?

Regards,
Willy

