Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUKRObZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUKRObZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbUKRObZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:31:25 -0500
Received: from holomorphy.com ([207.189.100.168]:2689 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262079AbUKRObY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:31:24 -0500
Date: Thu, 18 Nov 2004 06:31:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm2
Message-ID: <20041118143122.GF2268@holomorphy.com>
References: <20041118021538.5764d58c.akpm@osdl.org> <20041118135741.GE2268@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118135741.GE2268@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:15:38AM -0800, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/
>> - Lots of small bugfixes.  Some against patches in -mm, some against Linus's
>>   tree.
>> - There's a patch here which should address the oom-killings which a few
>>   people have reported.

On Thu, Nov 18, 2004 at 05:57:41AM -0800, William Lee Irwin III wrote:
> Whatever broke sparc64 (likely sunzilog.c) is between 2.6.9-bk2 and
> 2.6.9-bk3. I suspect serial changes.

rmk and I have narrowed it down to some bad interactions of sparc64
PROM console registration code with some console registration retry
logic and sunzilog.c oddities. I'll work this out with rmk and davem.


-- wli
