Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVAZXUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVAZXUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVAZXTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:19:18 -0500
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:34696 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S262456AbVAZR6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:58:08 -0500
Message-ID: <41F7DA1B.5060806@bigpond.net.au>
Date: Thu, 27 Jan 2005 04:57:47 +1100
From: Cal <hihone@bigpond.net.au>
Reply-To: hihone@bigpond.net.au
User-Agent: Mozilla Thunderbird 0.6+ (X11/20050122)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>
Subject: Re: [ck] [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D7
References: <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>	<41F6C5CE.9050303@bigpond.net.au> <41F6C797.80403@bigpond.net.au>	<20050126100846.GB8720@elte.hu> <41F7C2CA.2080107@bigpond.net.au> <87acqwnnx1.fsf@sulphur.joq.us>
In-Reply-To: <87acqwnnx1.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=0.93.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
> I notice that JACK's call to mlockall() is failing.  This is one
> difference between your system and mine (plus, my machine is UP).  
> 
> As an experiment, you might try testing with `ulimit -l unlimited'.

I went for the panic retraction on the first report when I saw the 
failures in the log.  With ulimit -l unlimited, jack seems happier. 
Before the change, ulimit -l showed 32.

At what feels like approaching the end of the run, it still goes clunk - 
totally so, dead and gone!

<http://www.graggrag.com/200501270420-oops/>

I'll re-read the mails that have gone by, and think about the next step.

cheers, Cal
