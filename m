Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVA0CJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVA0CJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVA0CFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 21:05:41 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:30193 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S262334AbVA0CD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 21:03:29 -0500
Message-ID: <41F84BDF.3000506@bigpond.net.au>
Date: Thu, 27 Jan 2005 13:03:11 +1100
From: Cal <hihone@bigpond.net.au>
Reply-To: hihone@bigpond.net.au
User-Agent: Mozilla Thunderbird 0.6+ (X11/20050122)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: hihone@bigpond.net.au, Ingo Molnar <mingo@elte.hu>,
       linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
Subject: Re: [ck] [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D7
References: <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>	<41F6C5CE.9050303@bigpond.net.au> <41F6C797.80403@bigpond.net.au>	<20050126100846.GB8720@elte.hu> <41F7C2CA.2080107@bigpond.net.au>	<87acqwnnx1.fsf@sulphur.joq.us> <41F7DA1B.5060806@bigpond.net.au> <87vf9km31j.fsf@sulphur.joq.us>
In-Reply-To: <87vf9km31j.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=0.93.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> You seem to have eliminated the mlock() failure as the cause of this
> crash.  It should not have caused it anyway, but it *was* one
> noticeable difference between your tests and mine.  Since
> do_page_fault() appears in the backtrace, that is useful to know.
> 
> The other big difference is SMP.  What happens if you build a UP
> kernel and run it on your SMP machine?

Sorry for the delay, some sleep required. A build without SMP also 
fails, with multiple oops.
   <http://www.graggrag.com/200501271213-oops/>.

cheers, Cal

(NetEase AntiSpam+ at mail.edu.cn has been bouncing someone's copy)
