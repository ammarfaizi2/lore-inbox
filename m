Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVGMUKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVGMUKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVGMUDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:03:51 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:64175 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262718AbVGMUDN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:03:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XC1do1uvztUB2e2wCRhzM3/UQBS1l5P+bT8MCYrnnq4qYQ/Mly+q/uYz4uS/KYRIdnYGRJZYbvH6eTr8W+Vn3hHv0Qy6LgjsNcihGyuP4Z9xmH9qEkvtSaOfRdgb9oGfAY4aoisH8edX9KZQ3gA+bbmv9xh5G7BCJGJvv/zkuWc=
Date: Wed, 13 Jul 2005 22:02:24 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-Id: <20050713220224.1da5da00.diegocg@gmail.com>
In-Reply-To: <1121282025.4435.70.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	<20050712121008.GA7804@ucw.cz>
	<200507122239.03559.kernel@kolivas.org>
	<200507122253.03212.kernel@kolivas.org>
	<42D3E852.5060704@mvista.com>
	<20050712162740.GA8938@ucw.cz>
	<42D540C2.9060201@tmr.com>
	<Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	<20050713184227.GB2072@ucw.cz>
	<Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	<1121282025.4435.70.camel@mindpipe>
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 13 Jul 2005 15:13:44 -0400,
Lee Revell <rlrevell@joe-job.com> escribió:

> How about 500?  This might be good enough to solve the MIDI problem.

In 2.4 suse kernels you could set HZ at boot time. Since it doesn't seems
possible to find a HZ value that makes everybody happy, would be feasible
to do what suse did?

Some distros are already carrying programs which try to guess if a box
is a laptop or not, and then set some parameters (laptop-mode, cpufreq)
if they are. If HZ could be set at boot time they could use those heuristics
to add a extra boot flag in the boot loader without needing to recompile
the kernel

It'd be very uselful for distros, the same distro can be installed in a
multimedia-oriented box or a laptop, and no default is going to make
everybody happy...
