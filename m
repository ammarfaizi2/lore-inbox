Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbUKVOk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUKVOk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbUKVOix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:38:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:64450 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262127AbUKVOWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:22:47 -0500
Date: Mon, 22 Nov 2004 16:24:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john cooper <john.cooper@timesys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041122152452.GA2036@elte.hu>
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk> <20041122092302.GA7210@nietzsche.lynx.com> <41A1F4B2.10401@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A1F4B2.10401@timesys.com>
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


* john cooper <john.cooper@timesys.com> wrote:

> I'd hazard a guess the reason existing implementations do not do this
> type of dependency-chain closure is the complexity of a general
> approach. [...]

please take a look at the latest patch, it is i believe handling all the
cases correctly. It certainly appears to solve the cases uncovered by
pi_test.

	Ingo
