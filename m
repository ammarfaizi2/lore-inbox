Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266827AbRIDSyX>; Tue, 4 Sep 2001 14:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266864AbRIDSyN>; Tue, 4 Sep 2001 14:54:13 -0400
Received: from freeside.toyota.com ([63.87.74.7]:529 "EHLO freeside.toyota.com")
	by vger.kernel.org with ESMTP id <S266827AbRIDSyF>;
	Tue, 4 Sep 2001 14:54:05 -0400
Message-ID: <3B952359.84FFC7C7@lexus.com>
Date: Tue, 04 Sep 2001 11:54:17 -0700
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
CC: Christopher Friesen <cfriesen@nortelnetworks.com>,
        Fred <fred@arkansaswebs.com>, linux-kernel@vger.kernel.org
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
In-Reply-To: <E15eHup-0003ir-00@the-village.bc.nu> <01090410264000.14864@bits.linuxball> <3B950034.17909E5D@nortelnetworks.com> <200109041823.f84INqE13918@maild.telia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:

> 1) Why shouldn't the low-latency patches work for another architecture?
> Andrew Morton might be interested to fix other architectures too.
> (but most patches are not in architecture specific code)
>
> 2) Montavistas reschedulable kernel is a very interesting approach, newly
> released an update by Robert Love
>   http://kpreempt.sourceforge.net/
>   http://tech9.net/rml/linux/patch-rml-2.4.10-pre2-preempt-kernel-1
> (there are still some spikes, but the floor is smooth)
>
> But note you with both approaches you want to run the latency critical process
> with a higher priority, and probably with the memory locked down.
>
> See example code (latencytest) at:
>  http://www.gardena.net/benno/linux/audio/
> (but there is no need to run at the maximum possible priority since your
>  process will be alone anyway...)

Just a data point here -

The Andrew Morton patches have worked well for
me here - I test it often with quake 3 arena, and am
currently on 2.4.10-pre4 -

I was never successful in getting the kernel to
compile and run with any of the the other low
latency patches floating around -

cu

jjs

