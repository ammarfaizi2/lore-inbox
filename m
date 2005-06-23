Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVFWOtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVFWOtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 10:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVFWOtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 10:49:12 -0400
Received: from [195.23.16.24] ([195.23.16.24]:15505 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262552AbVFWOtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 10:49:08 -0400
Message-ID: <42BACBC1.2090101@grupopie.com>
Date: Thu, 23 Jun 2005 15:48:33 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kristian Benoit <kbenoit@opersys.com>
Cc: paulmck@us.ibm.com, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, mingo@elte.hu, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost>	 <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com>	 <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com>	 <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost>
In-Reply-To: <1119460803.5825.13.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kristian Benoit wrote:
> [...]
> Your analysis is correct, but with 600,000 samples, it is possible that
> we got 2 peeks (perhaps not maximum), one on the logger and one on the
> target. So in my point of view, the maximum value is probably somewhere
> between 55us / 2 and 55us - 7us. And probably closer to 55us / 2.

I could provide some help here, by providing the schematics and firmware 
for having a microcontroller do the pulse timing part. The schematics 
should be extremely simple, and easy to build in a breadboard (no 
soldering required) with standard parts from electronics resellers.

With a hardware solution we could measure the *actual* target latency 
with sub-microsecond accuracy, and do some fun stuff too, like 
triggering the pulse at random intervals in a given range, etc.

The microcontroller would then connect to the logger (or the HOST in 
your setup, and avoid an extra computer) through a serial port to report 
the measurements.

Is this something that could be useful, or do you think this is just 
overkill?

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
