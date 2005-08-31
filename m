Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVHaPu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVHaPu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVHaPu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:50:56 -0400
Received: from imap.gmx.net ([213.165.64.20]:46222 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964848AbVHaPuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:50:46 -0400
X-Authenticated: #4399952
Date: Wed, 31 Aug 2005 17:50:36 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       jackit-devel@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, cc@ccrma.Stanford.EDU,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Jackit-devel] Re: jack, PREEMPT_DESKTOP, delayed interrupts?
Message-ID: <20050831175036.5640e221@mango.fruits.de>
In-Reply-To: <7q64tmnwbb.fsf@io.com>
References: <1125453795.25823.121.camel@cmn37.stanford.edu>
	<20050831073518.GA7582@elte.hu>
	<7q64tmnwbb.fsf@io.com>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005 07:08:08 -0500
"Jack O'Quin" <joq@io.com> wrote:

> JACK sources already include a CHECK_PREEMPTION() macro which expands
> to Ingo's special gettimeofday() calls.  The trace is turned on and
> then off automatically before and after the realtime critical section
> in the process thread (see libjack/client.c).  

Just for completeness sake:

you need to build jackd with --enable-preemption-check

Flo


-- 
Palimm Palimm!
http://tapas.affenbande.org
