Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUG1OZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUG1OZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267171AbUG1OZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:25:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28614 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267170AbUG1OZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:25:34 -0400
Date: Wed, 28 Jul 2004 16:26:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Message-ID: <20040728142649.GB29893@elte.hu>
References: <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu> <1090968457.743.3.camel@mindpipe> <20040728050535.GA14742@elte.hu> <1091015060.5560.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091015060.5560.9.camel@localhost>
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


* Thomas Charbonnel <thomas@undata.org> wrote:

> The other source of xrun was seen during the disk write tests, once
> the memory runs out (spikes up to 14 ms, but more generally 6 ms)

which particular filesystem and disk driver are you using? (ext3/IDE?) 
The 'disk write tests' are those of latencytest-0.5.4?

	Ingo
