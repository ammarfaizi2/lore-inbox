Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWCULyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWCULyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWCULyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:54:24 -0500
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:30093 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030365AbWCULyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:54:23 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: interactive task starvation
Date: Tue, 21 Mar 2006 22:53:02 +1100
User-Agent: KMail/1.9.1
Cc: Willy Tarreau <willy@w.ods.org>, Mike Galbraith <efault@gmx.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
References: <200603090036.49915.kernel@kolivas.org> <20060321111552.GA25651@w.ods.org> <20060321111850.GA2776@elte.hu>
In-Reply-To: <20060321111850.GA2776@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603212253.03637.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 March 2006 22:18, Ingo Molnar wrote:
> great work by Mike! One detail: i'd like there to be just one default
> throttling value, i.e. no grace_g tunables [so that we have just one
> default scheduler behavior]. Is the default grace_g[12] setting good
> enough for your workload?

I agree. If anything is required, a simple on/off tunable makes much more 
sense. Much like I suggested ages ago with an "interactive" switch which was 
rather unpopular when I first suggested it. Perhaps my marketing was wrong. 
Oh well.

Cheers,
Con
