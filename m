Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVC2DHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVC2DHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 22:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVC2DHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 22:07:48 -0500
Received: from fmr24.intel.com ([143.183.121.16]:8651 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262165AbVC2DHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 22:07:43 -0500
Message-Id: <200503290307.j2T37Yg25879@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Dave Jones'" <davej@redhat.com>
Cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] optimization: defer bio_vec deallocation
Date: Mon, 28 Mar 2005 19:07:30 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0C1v698JzM+cfQ6WN/UEZAZZbrwAACswA
In-Reply-To: <20050329025932.GC435@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 06:38:23PM -0800, Chen, Kenneth W wrote:
> We have measured that the following patch give measurable performance gain
> for industry standard db benchmark.  Comments?

Dave Jones wrote on Monday, March 28, 2005 7:00 PM
> If you can't publish results from that certain benchmark due its stupid
> restrictions, could you also try running an alternative benchmark that
> you can show results from ?
>
> These nebulous claims of 'measurable gains' could mean anything.
> I'm assuming you see a substantial increase in throughput, but
> how much is it worth in exchange for complicating the code?

Are you asking for micro-benchmark result?  I had a tough time last time
around when I presented micro-benchmark result on LKML.  I got kicked in
the butt for lack of evidence with performance data running real bench on
real hardware.

I guess either way, I'm bruised one way or the other.


