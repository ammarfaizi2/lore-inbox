Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUFSKOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUFSKOj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265470AbUFSKOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:14:39 -0400
Received: from holomorphy.com ([207.189.100.168]:3981 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265396AbUFSKOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:14:38 -0400
Date: Sat, 19 Jun 2004 03:14:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kaos@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.7] bug_smp_call_function
Message-ID: <20040619101427.GR1863@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, kaos@sgi.com,
	linux-kernel@vger.kernel.org
References: <5328.1087637808@kao2.melbourne.sgi.com> <20040619024416.065f4026.akpm@osdl.org> <20040619095910.GQ1863@holomorphy.com> <20040619030834.3582d2bd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619030834.3582d2bd.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Calls to smp_call_function() with interrupts off or spinlocks held
>> typically causes deadlocks on SMP systems.

On Sat, Jun 19, 2004 at 03:08:34AM -0700, Andrew Morton wrote:
> No, this doesn't "typically" deadlock.  It will deadlock on every ten
> millionth call.  The preceding 9,999,999 warnings should have imparted
> sufficient clue?

I wasn't counting function calls. I suppose it won't deadlock on every
call.


-- wli
