Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbULXVZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbULXVZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 16:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbULXVZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 16:25:28 -0500
Received: from holomorphy.com ([207.189.100.168]:38080 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261453AbULXVZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 16:25:25 -0500
Date: Fri, 24 Dec 2004 13:25:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [4/4]
Message-ID: <20041224212513.GV771@holomorphy.com>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random> <20041224125504.4caa4270.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041224125504.4caa4270.davem@davemloft.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 19:22:19 +0100 Andrea Arcangeli <andrea@suse.de> wrote:
>> If those old cpus really supported smp in linux, then fixing this bit is
>> trivial, just change it to short. Do they support short at least?

On Fri, Dec 24, 2004 at 12:55:04PM -0800, David S. Miller wrote:
> No, they do not.  The smallest atomic unit is one 32-bit word.
> And yes there are SMP systems using these chips.

Would systems described as ev56 by /proc/cpuinfo have such chips?


-- wli
