Return-Path: <linux-kernel-owner+w=401wt.eu-S932251AbWLRXrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWLRXrD (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWLRXrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:47:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45333 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932251AbWLRXrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:47:01 -0500
Date: Mon, 18 Dec 2006 18:45:49 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] debugging feature: SysRq-Q to print timers
Message-ID: <20061218234549.GB32353@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
References: <20061214225913.3338f677.akpm@osdl.org> <20061216000440.GY3388@stusta.de> <20061216075658.GA16116@elte.hu> <20061218153103.57860bf8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218153103.57860bf8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 03:31:03PM -0800, Andrew Morton wrote:
 > On Sat, 16 Dec 2006 08:56:58 +0100
 > Ingo Molnar <mingo@elte.hu> wrote:
 > 
 > > ----------------->
 > > Subject: [patch] debugging feature: SysRq-Q to print timers
 > > From: Ingo Molnar <mingo@elte.hu>
 > > 
 > > add SysRq-Q to print pending timers and other timer info.
 > 
 > I must say that I've never needed this feature or /proc/timer-list, and I
 > don't recall ever having seen anyone request it, nor get themselves into a
 > situation where they needed it.

/proc/timer-list is useful for profiling applications doing excessive wakeups.
With the move towards being tickless, this is more important than ever,
and giving users the right tools to find these problems themselves is important.

		Dave

-- 
http://www.codemonkey.org.uk
