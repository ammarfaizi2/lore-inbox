Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269286AbUJKV7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269286AbUJKV7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUJKV7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:59:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59535 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269286AbUJKV57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:57:59 -0400
Date: Mon, 11 Oct 2004 23:59:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@Raytheon.com
Cc: Andrew Morton <akpm@osdl.org>, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: [patch] VP-2.6.9-rc4-mm1-T5
Message-ID: <20041011215909.GA20686@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:

> I would have to say this is "very rough" at this point. I had the
> following problems in the build:

i've uploaded -T5 which should fix most of the build issues:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T5

CONFIG_PREEMPT_REALTIME is still an experimental feature and defaults to
'n'.

-T5 will likely not fix the exit.c warnings, which, unless they are
accompanied by real crashes, should be mostly harmless. (famous last
words.) (The zombie task and self-reaping thread handling is a really
hard nut to crack, and i have nobody but me to blame for that code ...)

	Ingo
