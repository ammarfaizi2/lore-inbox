Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUJGSxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUJGSxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUJGSvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:51:08 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:29060 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267807AbUJGStl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:49:41 -0400
Subject: Re: Default cache_hot_time value back to 10ms
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com, kernel@kolivas.org,
       mingo@elte.hu, Andrew Morton OSDL <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1097174661.2669.310.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Oct 2004 14:44:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas writes:

> Should it not be based on the cache flush time? We measure
> that and set the cache_decay_ticks and can base it on that.

Often one must use the time, but...

If the system goes idle for an hour, the last-run
process is still cache-hot.

Many systems let you measure cache line castouts.
Time is a very crude approximation of this.
Memory traffic is a slightly better approximation.


