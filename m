Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270697AbTHAJSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 05:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270699AbTHAJSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 05:18:21 -0400
Received: from skunk.physik.uni-erlangen.de ([131.188.163.240]:62181 "EHLO
	skunk.physik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S270697AbTHAJSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 05:18:20 -0400
From: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>
Date: Fri, 1 Aug 2003 11:18:15 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test2: Never using pm_idle (CPU wasting power)
Message-ID: <20030801111815.A14236@skunk.physik.uni-erlangen.de>
References: <20030731150722.A5938@skunk.physik.uni-erlangen.de> <20030731155948.1826b9c7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20030731155948.1826b9c7.akpm@osdl.org>; from akpm@osdl.org on Thu, Jul 31, 2003 at 03:59:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, Jul 31, 2003 at 03:59:48PM -0700, Andrew Morton wrote:
> Yes, I assume that need_resched() is always false because kernel preemption
> cuts in first.  Can you please confirm that you're using CONFIG_PREEMPT,
> and that the problem goes away if CONFIG_PREEMPT is disabled?

Yes I was using PREEMPT, unfortunately the machine is not here right
now so I can't test without it. Your diff is also exactly what I did and
it helped. (I already wrote that).

	Chris

-- 
Smith & Wesson: The original point-and-click interface
