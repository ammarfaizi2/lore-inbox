Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266708AbUIORzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266708AbUIORzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267223AbUIORxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:53:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37314 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266708AbUIORwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:52:15 -0400
Message-ID: <41488140.4050109@pobox.com>
Date: Wed, 15 Sep 2004 13:52:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ricky Beam <jfbeam@bluetronic.net>,
       Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
References: <Pine.GSO.4.33.0409151255240.10693-100000@sweetums.bluetronic.net> <1095270555.2406.154.camel@krustophenia.net>
In-Reply-To: <1095270555.2406.154.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Interesting.  Still, this looks like a specific bug that needs fixing,
> it doesn't imply that preemption is a hack.  For many workloads
> preemption is a necessity.


For any workload that you feel preemption is a necessity, that indicates 
a latency problem in the kernel that should be solved.

Preemption is a hack that hides broken drivers, IMHO.

I would rather directly address any latency problems that appear.

	Jeff


