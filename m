Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVGWBnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVGWBnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 21:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVGWBnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 21:43:15 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:18596 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262263AbVGWBnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 21:43:13 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: IDE Zip drive doesn't work under 2.6.12
Date: Sat, 23 Jul 2005 11:43:04 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <jf73e1db6h1b23o7p2qj7nlijujdh7md0i@4ax.com>
References: <Pine.GSO.4.58.0507211045180.28914@denali.ccs.neu.edu>
In-Reply-To: <Pine.GSO.4.58.0507211045180.28914@denali.ccs.neu.edu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2005 11:21:05 -0400 (EDT), Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
>
>Recently I upgraded from 2.6.11.11 to 2.6.12.3.  This morning I tried
>using my Zip drive... unfortunately it doesn't work under 2.6.12.3.  To
>verify that this was a kernel problem, I rebooted to 2.6.11.11.  Here's
>some relevant output using 2.6.11.11:

I too see this issue, but it doesn't go away on 2.6.11.12 for me, 
something is eating /dev/ nodes, writing to them, this doesn't 
happen in 2.4, so yet another "don't do that", or user-space, I 
haven't the foggiest.

fdisk sees the drive on 2.6, 2.4 sees it okay on same hardware

usb-storage also stomps /dev/sdX nodes on this and a different box, 
so something odd is happening with removable storage.

Grant.

