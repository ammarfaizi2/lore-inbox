Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268819AbUJPUBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268819AbUJPUBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUJPT7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:59:53 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:52987 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S268819AbUJPT7j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:59:39 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
References: <41650CAF.1040901@unimail.com.au>
	<20041007103210.GA32260@atrey.karlin.mff.cuni.cz>
	<yw1x7jq2n6k3.fsf@mru.ath.cx>
	<20041007143245.GA1698@openzaurus.ucw.cz>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Date: Sat, 16 Oct 2004 21:59:25 +0200
In-Reply-To: <20041007143245.GA1698@openzaurus.ucw.cz> (Pavel Machek's
 message of "Thu, 7 Oct 2004 16:32:46 +0200")
Message-ID: <yw1x1xfyl9ia.fsf@ford.guide>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> >> Is there any way to stop this? I googled around and found it had 
>> >> something to do with idle frequency of 1000 Hz in 2.6 instead of 100Hz 
>> >> in the 2.4 kernel. I couldn't find much else on this. Hunting around the 
>> >> code didn't help much, I don't know C. 
>> >
>> > Change #define HZ 1000 to #define HZ 100...
>> 
>> ... and lose all the benefits of HZ=1000.  
>
> What benefits? HZ=1000 takes 1W more on my system.

Isn't it supposed to give more accurate timing?

>> What would happen if one
>> were to set HZ to a higher value, like 10000?
>
> Try it.
>
>> > Boycott Kodak -- for their patent abuse against Java.
>> 
>> Actually, I don't know which is worse, patent abuse or Java misuse.
>
> Well, java is ugly but not dangerous.
> 				Pavel
> -- 
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

Has that really happened?

-- 
Måns Rullgård
mru@mru.ath.cx
