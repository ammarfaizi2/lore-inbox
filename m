Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTIBRwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTIBRu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:50:28 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2571
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261877AbTIBRU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:20:59 -0400
Date: Tue, 2 Sep 2003 10:21:02 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030902172102.GA13684@matchmail.com>
Mail-Followup-To: Takao Indoh <indou.takao@soft.fujitsu.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030827113646.GC4306@holomorphy.com> <23C371405B0858indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23C371405B0858indou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 07:52:51PM +0900, Takao Indoh wrote:
> >> According to this information, I thought that
> >> all pagecache was 732360 kB and all mapped page was 73360 kB, so
> >> almost of pagecache was not mapped...
> >> Do I misread meminfo?

Can you try your workload again with:

echo 0 > /proc/sys/vm/swappiness
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 07:52:51PM +0900, Takao Indoh wrote:
> >> According to this information, I thought that
> >> all pagecache was 732360 kB and all mapped page was 73360 kB, so
> >> almost of pagecache was not mapped...
> >> Do I misread meminfo?

Can you try your workload again with:

echo 0 > /proc/sys/vm/swappiness
