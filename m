Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUGZJYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUGZJYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 05:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUGZJYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 05:24:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1664 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265087AbUGZJYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 05:24:33 -0400
Date: Mon, 26 Jul 2004 11:25:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: preempt timing violations
Message-ID: <20040726092529.GB25904@elte.hu>
References: <1090813907.6936.56.camel@mindpipe> <20040726085002.GA25519@elte.hu> <1090832953.6936.114.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090832953.6936.114.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> 2 and 1.  Now that I think about it, this could have happened during
> bootup, before my rc.local set these.  I will try passing them on the
> kernel command line. 

the kernel command line option for immediate 2:1 is:

  "voluntary-preempt=2 preempt=1"

	Ingo
