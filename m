Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270229AbUJTLdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270229AbUJTLdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270125AbUJTLdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:33:50 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:22343 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S270201AbUJTLdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:33:11 -0400
Message-ID: <15773.195.245.190.94.1098271919.squirrel@195.245.190.94>
In-Reply-To: <20041020104005.GA1813@elte.hu>
References: <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
    <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
    <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
    <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
    <20041020100424.GA32396@elte.hu>
    <11742.195.245.190.93.1098268363.squirrel@195.245.190.93>
    <20041020104005.GA1813@elte.hu>
Date: Wed, 20 Oct 2004 12:31:59 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 20 Oct 2004 11:33:06.0806 (UTC) FILETIME=[91A5C160:01C4B698]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>Rui Nuno Capela wrote:
>> >
>> > - fix block-loopback assert reported by Mark H Johnson, Matthew L
>> >   Foster and Rui Nuno Capela. (usually triggers during 'make install'
>> >   of a kernel compile.)
>> >
>>
>> Is this fix already on U8 ? I don't seem to get out of mkinitrd (which
>> is triggered by kernel make install).
>
> please re-download -U8, i've updated it a couple of minutes after
> uploading it, but apparently not fast enough :-| Sorry!
>

OK. No problem.... and yes, mkinitrd (make install) works again.


>> OTOH, still on my laptop (P4/UP) I'm getting this very often:
>>
>> RTNL: assertion failed at net/ipv4/devinet.c (1049)
>
> yeah - this too was an oversight i fixed in the latest upload.

I don't think so. I still see plenty of those here.

Is there an even more recent U8? I think you should consider add some dot
numbering to each of the uploads... ;)

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


