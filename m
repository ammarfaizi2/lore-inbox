Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVAUTWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVAUTWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVAUTWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:22:36 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:37098 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262539AbVAUTWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:22:23 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: [ia64] compile error
Date: Fri, 21 Jan 2005 11:22:13 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200501211911.j0LJBOtm029047@work.bitmover.com>
In-Reply-To: <200501211911.j0LJBOtm029047@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501211122.14049.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 21, 2005 11:11 am, Larry McVoy wrote:
> Just pulled.
>
> In file included from arch/ia64/mm/discontig.c:23:
> include/linux/nodemask.h: In function `__first_unset_node':
> include/linux/nodemask.h:246: warning: passing arg 1 of
> `__find_next_zero_bit' discards qualifiers from pointer target type
> arch/ia64/mm/discontig.c: In function `find_pernode_space':
> arch/ia64/mm/discontig.c:389: error: `__per_cpu_offset' undeclared (first
> use in this function) arch/ia64/mm/discontig.c:389: error: (Each undeclared
> identifier is reported only once arch/ia64/mm/discontig.c:389: error: for
> each function it appears in.) arch/ia64/mm/discontig.c:548:24: macro
> "per_cpu_init" passed 1 arguments, but takes just 0
> arch/ia64/mm/discontig.c: At top level:
> arch/ia64/mm/discontig.c:549: error: syntax error before '{' token

What config?  CONFIG_SMP=n won't work if you're trying to build a 
CONFIG_IA64_GENERIC kernel (at least not yet, Tony's got some fixes pending).

Jesse
