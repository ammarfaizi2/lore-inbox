Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270775AbTG0Nnk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 09:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270776AbTG0Nnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 09:43:39 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:19098
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270775AbTG0Nnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 09:43:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
Date: Mon, 28 Jul 2003 00:03:04 +1000
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307280003.05185.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 23:40, Ingo Molnar wrote:
>  - further increase timeslice granularity

For a while now I've been running a 1000Hz 2.4 O(1) kernel tree that uses 
timeslice granularity set to MIN_TIMESLICE which has stark smoothness 
improvements in X. I've avoided promoting this idea because of the 
theoretical drop in throughput this might cause. I've not been able to see 
any detriment in my basic testing of this small granularity, so I was curious 
to see what you throught was a reasonable lower limit?

Con

