Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVEWH4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVEWH4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 03:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEWH4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 03:56:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46571 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261866AbVEWHz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 03:55:29 -0400
Date: Mon, 23 May 2005 09:55:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: weird X problem - priority inversion?
Message-ID: <20050523075508.GC9287@elte.hu>
References: <1113428938.16635.13.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113428938.16635.13.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


does this still occur with the latest tree? (.47-05 or later)

	Ingo

* Lee Revell <rlrevell@joe-job.com> wrote:

> I am having a problem with the RT preempt kernels where xscreensaver
> will cause the X server to consume excessive CPU, starving other
> processes.  This should not happen as xscreensaver runs at the highest
> nice value.  It seems that there's some kind of priority inversion
> happening between the high prio X server and low prio xscreensaver.
> 
> This seems like an X problem to me, but could the kernel be involved?
> 
> Lee
