Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbUJ1PYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUJ1PYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUJ1PWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:22:44 -0400
Received: from holomorphy.com ([207.189.100.168]:18313 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261713AbUJ1PNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:13:40 -0400
Date: Thu, 28 Oct 2004 08:13:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, uclibc@uclibc.org
Subject: Re: Swap strangeness: total VIRT ~23mb for all processes, swap 91156k used - impossible?
Message-ID: <20041028151323.GM12934@holomorphy.com>
References: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 01:33:53PM +0300, Denis Vlasenko wrote:
> I am playing with 'small/beautiful stuff' like
> bbox/uclibc.
> I ran oom_trigger soon after boot and took
> "top b n 1" snapshot after OOM kill.
> Output puzzles me: total virtual space taken by *all*
> processes is ~23mb yet swap usage is ~90mb.
> How that can be? *What* is there? Surely it can't
> be a filesystem cache because OOM condition reduces that
> to nearly zero.
> top output
> (note: some of them are busybox'ed, others are compiled
> against uclibc, some are statically built with dietlibc,
> rest is plain old shared binaries built against glibc):

Let's get top(1) out of the equation. Could you grab VSZ from directly
from /proc/?


Thanks.


-- wli
