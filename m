Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbUJZEMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbUJZEMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUJZEDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:03:02 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9915 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262152AbUJZD6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 23:58:19 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
In-Reply-To: <417DC046.1020806@cybsft.com>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
	 <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com>
	 <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu>
	 <20041025152458.3e62120a@mango.fruits.de> <20041025132605.GA9516@elte.hu>
	 <20041025160330.394e9071@mango.fruits.de> <20041025141008.GA13512@elte.hu>
	 <20041025141628.GA14282@elte.hu>
	 <33313.192.168.1.5.1098733224.squirrel@192.168.1.5>
	 <1098759671.9166.10.camel@krustophenia.net>  <417DC046.1020806@cybsft.com>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 23:58:12 -0400
Message-Id: <1098763092.9166.17.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 22:11 -0500, K.R. Foley wrote:
>  
> Not being familiar with jack, does it use rtc?
> 

No it normally uses the soundcard for timing.  For testing there is a
dummy backend that just usleep()s.  This makes a pretty useful latency
tester.

Lee

