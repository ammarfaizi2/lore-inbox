Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVBTATQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVBTATQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 19:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVBTATP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 19:19:15 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44720 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262326AbVBTATH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 19:19:07 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1108845942.10705.27.camel@krustophenia.net>
References: <20050204100347.GA13186@elte.hu>
	 <1108789704.8411.9.camel@krustophenia.net> <20050219090036.GA30456@elte.hu>
	 <20050219090312.GA30513@elte.hu>
	 <1108845942.10705.27.camel@krustophenia.net>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 19:19:04 -0500
Message-Id: <1108858744.11675.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 15:45 -0500, Lee Revell wrote:
> I have not tried "data=journal".  As previously stated "data=writeback"
> works perfectly - I ran JACK overnight while stressing the fs and did
> not get one xrun.

"data=journal" has the same good performance as "data=writeback".  Only
the ordered data mode is affected.

Lee

