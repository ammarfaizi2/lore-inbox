Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751866AbWHULCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbWHULCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWHULCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:02:23 -0400
Received: from i59F55009.versanet.de ([89.245.80.9]:43787 "EHLO
	max.erig.daheim") by vger.kernel.org with ESMTP id S1751866AbWHULCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:02:22 -0400
Date: Mon, 21 Aug 2006 13:02:20 +0200
From: Wolfgang Erig <Wolfgang.Erig@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Regression with hyper threading scheduling
Message-ID: <20060821110220.GB6649@erig.dyndns.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20060819223910.fef3bdea.akpm@osdl.org> <44E81770.8080408@bigpond.net.au> <44E9015E.4030808@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E9015E.4030808@bigpond.net.au>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 10:42:06AM +1000, Peter Williams wrote:
> Peter Williams wrote:
> >Andrew Morton wrote:
> ...
> >I'm unable to reproduce this problem with 2.6.18-rc4 on my HT system. 
> >I'm using top with the "last processor" field enabled to observe (rather 
> >than the methods described) and the two bash shells are both getting 
> >100% and are each firmly affixed to different CPUs.
> 
> Doing a "cat /proc/stat" also indicates that the problem is not present.
> 
> I wonder if the two xterms and/or their shells are have different nice 
> values (or scheduling policies)?
No.

> Also is the presence of PREEMPT in the uname output for the 2.6.17.8 
> kernel (not present in the 2.6.8.1 kernel's output) significant? 
> Presuming that this signifies the CONFIG_PREEMPT option is selected it 
> is worth noting that I do not have this selected in the kernel I tested.
We have tried witn and without CONFIG_PREEMPT and saw the same problem.

Wolfgang
