Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVAPXNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVAPXNi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 18:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVAPXNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 18:13:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3993 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262642AbVAPXNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 18:13:34 -0500
Date: Mon, 17 Jan 2005 00:13:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050116231307.GC24610@elte.hu>
References: <200501111305.j0BD58U2000483@localhost.localdomain> <20050111191701.GT2940@waste.org> <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu> <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us> <20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us> <871xcmuuu4.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871xcmuuu4.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> According to the manpage, nice(2) is per-process not per-thread.  That
> does not give the granularity we need. 

the manpage is incorrect - sys_nice() is per-thread. (Btw., you could
use setpriority() too.)

	Ingo
