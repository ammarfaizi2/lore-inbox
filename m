Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVGKQxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVGKQxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVGKQvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:51:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7407 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262177AbVGKQtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:49:53 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread, take 2
From: Daniel Walker <dwalker@mvista.com>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050711164322.GD1304@us.ibm.com>
References: <20050711145552.GA1489@us.ibm.com>
	 <1121098272.7050.13.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050711164322.GD1304@us.ibm.com>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 09:49:48 -0700
Message-Id: <1121100589.7050.24.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 09:43 -0700, Paul E. McKenney wrote:
> Hello, Daniel,
> 
> In principle, one could inspect the Linux kernel with the PREEMPT_RT patch
> applied, and calculate the worst-case time during which interrupts are
> disabled, though I have not heard of anyone actually doing this.  Is this
> what you are getting at, or are you thinking in terms of Kristian's and
> Karim's testing?

Well with the PREEMPT_RT patch applied the interrupt off sections are
reduced to a small number, ~100 irrespective of config options or
drivers (although I think APM might be the one exception) .

So with the patch applied it becomes trivial to test/inspect each of the
interrupt off sections , and thus give a hard guarantee for _all_
PREEMPT_RT kernels. 

Daniel

