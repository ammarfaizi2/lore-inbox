Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUJEULD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUJEULD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUJEUHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:07:23 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:65372 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S265331AbUJEUDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:03:43 -0400
Message-ID: <32851.192.168.1.5.1097006509.squirrel@192.168.1.5>
In-Reply-To: <20041005194458.GA15629@elte.hu>
References: <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
    <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu>
    <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu>
    <20041005134707.GA32033@elte.hu>
    <32799.192.168.1.5.1096994246.squirrel@192.168.1.5>
    <20041005184226.GA10318@elte.hu>
    <32787.192.168.1.5.1097005084.squirrel@192.168.1.5>
    <20041005194458.GA15629@elte.hu>
Date: Tue, 5 Oct 2004 21:01:49 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, "Florian Schmidt" <mista.tapas@gmx.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 05 Oct 2004 20:03:40.0406 (UTC) FILETIME=[687FE960:01C4AB16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela wrote:
>
>> OTOH, I've tested T1 with CONFIG_SCHED_SMT and/or CONFIG_SMP not set,
>> and got similar crashes too. So this seems to be some nasty bug
>> introduced by -mm{1,2}, not by VP on SMP/SMT.
>>
>> Yes, I do have some critical USB devices around here. One is that
>> wacom tablet (mouse) and the other is a tascam us-224 audio/midi
>> control surface that a love very much :)
>>
>> Don't know if this makes me feeling better, doh.
>
> i believe Andrew said that these USB problems should be fixed in the
> next -mm iteration.
>

Oh yes, I really do hope so :)

Meanwhile, I'm stuck with 2.6.9-rc2-mm4-S7 (SMP), but happy.

Strange thing is, that on my laptop, 2.6.9-rc3-mm2-S9 (UP) is doing just
fine. Guess that ohci_hcd now makes the difference here, against the
former which makes uhci_hcd bad behaved atm.

Thanks Ingo.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

