Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVG3Bty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVG3Bty (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVG3BsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 21:48:25 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:55197 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262745AbVG3Bpn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 21:45:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YSz6eMMqahqtCZYuiKlh2lusl2ypDngG2P4Lll/YPgdHkdPi2AHHtC/nvvGPM+2wf5icoJyFFFUrPL6SkXd+rX7QKsULDWv+67fJQ2ukFjfwMt1WrJ8CELNwIWchihdAKBjldfcuTE7pTcKgSdYU5wNemH1/j2awlp/0IgH7BFM=
Message-ID: <86802c4405072918451cd36138@mail.gmail.com>
Date: Fri, 29 Jul 2005 18:45:41 -0700
From: yhlu <yhlu.kernel@gmail.com>
Reply-To: yhlu <yhlu.kernel@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64: sync_tsc fix the race (so we can boot)
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <86802c4405072917525cfacc38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com>
	 <86802c44050728092275e28a9a@mail.gmail.com>
	 <86802c4405072810352d564fd3@mail.gmail.com>
	 <m1ll3q5mx3.fsf@ebiederm.dsl.xmission.com>
	 <86802c4405072913415379c5a4@mail.gmail.com>
	 <m1oe8lf7o9.fsf@ebiederm.dsl.xmission.com>
	 <86802c4405072917525cfacc38@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

Latest tree works.

YH


Booting processor 1/4 APIC 0x1
Initializing CPU#1
masked ExtINT on CPU#1
Calibrating delay using timer specific routine.. 4000.31 BogoMIPS (lpj=8000624)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
 stepping 0a
CPU 1: Syncing TSC to CPU 0.
Booting processor 2/4 APIC 0x2
Initializing CPU#2
masked ExtINT on CPU#2
CPU 1: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 896 cycles)
Calibrating delay using timer specific routine.. 4000.28 BogoMIPS (lpj=8000572)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(1) -> Node 2 -> Core 0
 stepping 0a
CPU 2: Syncing TSC to CPU 0.
Booting processor 3/4 APIC 0x3
Initializing CPU#3
masked ExtINT on CPU#3
CPU 2: synchronized TSC with CPU 0 (last diff -2 cycles, maxerr 909 cycles)
Calibrating delay using timer specific routine.. 4000.15 BogoMIPS (lpj=8000317)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(1) -> Node 3 -> Core 0
 stepping 0a
CPU 3: Syncing TSC to CPU 0.
Brought up 4 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs...<6>CPU 3: synchronized TSC with CPU 0
(last diff -16 cycles, maxerr 1496 cycles)
