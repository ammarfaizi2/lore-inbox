Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVA0Mt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVA0Mt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 07:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVA0Mt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 07:49:28 -0500
Received: from gizmo03bw.bigpond.com ([144.140.70.13]:6620 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S262599AbVA0MtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 07:49:19 -0500
Message-ID: <41F8E33A.9030100@bigpond.net.au>
Date: Thu, 27 Jan 2005 23:48:58 +1100
From: Cal <hihone@bigpond.net.au>
Reply-To: hihone@bigpond.net.au
User-Agent: Mozilla Thunderbird 0.6+ (X11/20050122)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: "Jack O'Quin" <joq@io.com>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, Mike Galbraith <efault@gmx.de>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D8
References: <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <41F6C5CE.9050303@bigpond.net.au> <41F6C797.80403@bigpond.net.au> <20050126100846.GB8720@elte.hu> <41F7C2CA.2080107@bigpond.net.au> <87acqwnnx1.fsf@sulphur.joq.us> <41F7DA1B.5060806@bigpond.net.au> <87vf9km31j.fsf@sulphur.joq.us> <41F84BDF.3000506@bigpond.net.au> <20050127085120.GF22482@elte.hu>
In-Reply-To: <20050127085120.GF22482@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000001, version=0.93.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> thanks, this pinpointed the bug - i've uploaded the -D8 patch to the
> usual place:
> 
>   http://redhat.com/~mingo/rt-limit-patches/
> 
> does it fix your crash? Mike Galbraith reported a crash too that i think
> could be the same one.

Yep, with D8 and SMP the test completes successfully.

cheers, Cal
