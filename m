Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269193AbUJQRVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269193AbUJQRVr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269206AbUJQRVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:21:47 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:47812 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269193AbUJQRVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:21:45 -0400
Message-ID: <32798.192.168.1.5.1098033608.squirrel@192.168.1.5>
In-Reply-To: <20041017161228.GB22620@elte.hu>
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
    <1097888438.6737.63.camel@krustophenia.net>
    <1097894120.31747.1.camel@krustophenia.net>
    <20041016064205.GA30371@elte.hu>
    <1097917325.1424.13.camel@krustophenia.net>
    <20041016103608.GA3548@elte.hu>
    <32801.192.168.1.5.1098018846.squirrel@192.168.1.5>
    <20041017132107.GA18462@elte.hu>
    <32793.192.168.1.5.1098023139.squirrel@192.168.1.5>
    <20041017161228.GB22620@elte.hu>
Date: Sun, 17 Oct 2004 18:20:08 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Daniel Walker" <dwalker@mvista.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Andrew Morton" <akpm@osdl.org>, "Adam Heath" <doogie@debian.org>,
       "Lorenzo Allegrucci" <l_allegrucci@yahoo.it>,
       "Andrew Rodland" <arodland@entermail.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 17 Oct 2004 17:21:43.0760 (UTC) FILETIME=[C5E26500:01C4B46D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> Rui Nuno Capela wrote:
>
>> > eth0: 3Com Gigabit LOM (3C940)
>> > eth0: network connection down
>> >       PrefPort:A  RlmtMode:Check Link State
>> >
>> > is this normal? Could the stall simply be a bootup stall due to no
>> > network available?
>> >
>>
>> Yes, I think it's normal. The fact is that on the non-RT kernel, the
>> eth0 device comes up immediately after, as you can see on
>> minicom.cap.{6,7,8} capture files.
>
> ok, then please try to do a sysrq-T. The bootup is soft-hung for some
> reason, lets see what tasks are around.
>

Hey, all the captured files I've sent, minicom.cap{0,1,2,3,4,5}, includes
the SysRq-T output, taken right after the hang. Am I missing something?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

