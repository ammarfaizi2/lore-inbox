Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVHOFry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVHOFry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 01:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVHOFry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 01:47:54 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:57360 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751080AbVHOFrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 01:47:53 -0400
Date: Mon, 15 Aug 2005 07:25:24 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Preemptive patch for 2.4.25
Message-ID: <20050815052523.GE20363@alpha.home.local>
References: <ddp1vo$1fn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddp1vo$1fn$1@sea.gmane.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 01:25:56PM +1000, Dmytro Bablinyuk wrote:
> I hope this is the right place to ask. My apologise if it's wrong.
> I have found 2.4.25-low-latency.patch.gz for the 2.4.25 kernel but I 
> couldn't find preemptible patch for this version of kernel.
> I found preempt-kernel-rml-2.4.23-pre5-1.patch and 
> preempt-kernel-rml-2.4.26-pre5-1.patch which are pretty close but not 
> exactly for the same version.

That's not a problem, they will work. But you should not use 2.4.25, but
rather 2.4.31 or even 2.4.32-preX, several security vulnerabilities and
bugs have been fixed since, and the code has not changed much, so most of
those patches still apply without a glitch.

You can also check in my tree, there are several updated patches + the glue
needed for them to apply correctly when needed, it may save you some time :

  http://w.ods.org/kernel/2.4-wt/2.4.31-wt1/patches-2.4.31-wt1/

Regards,
Willy

