Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbUKEMS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbUKEMS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 07:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbUKEMRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 07:17:13 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:21008 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262661AbUKEMQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 07:16:50 -0500
Message-ID: <418B6F32.4000703@blueyonder.co.uk>
Date: Fri, 05 Nov 2004 12:16:50 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Michael J. Cohen" <mjc@unre.st>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
References: <20041104100634.GA29785@elte.hu> <1099563805.30372.2.camel@localhost> <1099567061.7911.4.camel@localhost> <20041104114545.GA3722@elte.hu> <1099573171.7876.0.camel@optie.uni.325i.org> <1099575262.8110.1.camel@optie.uni.325i.org> <20041104140528.GA16604@elte.hu> <1099577631.8090.4.camel@optie.uni.325i.org> <20041104142317.GA19476@elte.hu> <1099593117.7982.14.camel@optie.uni.325i.org> <20041104193819.GB10107@elte.hu>
In-Reply-To: <20041104193819.GB10107@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Nov 2004 12:17:17.0563 (UTC) FILETIME=[643B2CB0:01C4C331]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Michael J. Cohen <mjc@unre.st> wrote:
> 
> 
>>threw in your tcp_window oneliner mentioned in another thread and that
>>seemed to curb the lockups I was getting.  xmms+jackd in realtime mode
>>is getting some xruns during any kind of IDE activity. network isn't
>>quite as fussy.
> 
> 
> hm, have you chrt-ed the soundcard IRQ to a fifo priority higher than
> 50?
> 
> 	Ingo
> 
> 
> 
V0.7.11 builds OK. It reboots at the line where it deals with the 
TouchPad, no capture of the error possible.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
