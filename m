Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269477AbUIZCSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269477AbUIZCSB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 22:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269485AbUIZCSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 22:18:00 -0400
Received: from holomorphy.com ([207.189.100.168]:60909 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269477AbUIZCR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 22:17:59 -0400
Date: Sat, 25 Sep 2004 19:17:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sched.h 6/8] move aio include to mm.h
Message-ID: <20040926021751.GT9106@holomorphy.com>
References: <20040925024513.GL9106@holomorphy.com> <20040925032419.GQ9106@holomorphy.com> <20040925032616.GR9106@holomorphy.com> <200409260356.27499.arnd@arndb.de> <20040926020637.GS9106@holomorphy.com> <1096164911.3697.39.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096164911.3697.39.camel@krustophenia.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-25 at 22:06, William Lee Irwin III wrote:
>> Grepping by hand turned up 186 files missing potentially missing direct
>> includes of workqueue.h, though I don't have a way to tell if I got
>> false negatives.

On Sat, Sep 25, 2004 at 10:15:12PM -0400, Lee Revell wrote:
> Can't you just try to build it with allyesconfig and see what breaks?

No, architectural ifdefs, not always done directly in drivers, fool
that, among other things, e.g. turning an option on can bring in the
header under various circumstances.


-- wli
