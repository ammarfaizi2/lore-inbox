Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVAMBw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVAMBw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVAMBv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:51:57 -0500
Received: from news.cistron.nl ([62.216.30.38]:47002 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261457AbVALVUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:20:21 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: High write latency, iowait, slow writes 2.6.9
Date: Wed, 12 Jan 2005 21:20:18 +0000 (UTC)
Organization: Cistron Group
Message-ID: <cs44ai$oet$1@news.cistron.nl>
References: <41E4BB99.90908@zanfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1105564818 25053 62.216.29.200 (12 Jan 2005 21:20:18 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <41E4BB99.90908@zanfx.com>,
Paul A. Sumner <paul@zanfx.com> wrote:
>I have a new server that during big io tasks, e.g., bonnie++ and
>tiobench testing, becomes very unresponsive. Both bonnie++ and tiobench
>show good read performance, but the write performance lags, max
>latencies are into the *minutes* and it experiences extended high
>iowait. I'm guessing the iowait may not be a real problem. The machine
>is as follows:

Try another IO scheduler (boot with elevator=deadline or elevator=cfq
 on the kernel command line)

Mike.

