Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSJHP4u>; Tue, 8 Oct 2002 11:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbSJHP4u>; Tue, 8 Oct 2002 11:56:50 -0400
Received: from aneto.able.es ([212.97.163.22]:3714 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id <S261205AbSJHP4t>;
	Tue, 8 Oct 2002 11:56:49 -0400
Date: Tue, 8 Oct 2002 18:02:10 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Rik van Riel <riel@conectiva.com.br>
Cc: procps-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] procps 2.0.10
Message-ID: <20021008160210.GA3268@werewolf.able.es>
References: <Pine.LNX.4.44L.0210081204000.1909-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44L.0210081204000.1909-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Oct 08, 2002 at 17:05:34 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.08 Rik van Riel wrote:
>On Tue, 8 Oct 2002, J.A. Magallon wrote:
>
>> >should always be 0.0% and it always is 0.0% here.
>> >
>> >I have no idea why it's displaying a wrong value on your
>> >system, unless you somehow managed to run against a wrong
>> >libproc.so (shouldn't happen).
>>
>> It looks like the 2 first screenshots show buggy data:
>
>Yup, that's the bug I fixed friday.  Wait a moment, I fixed
>it for five_cpu_numbers(), but probably not for the SMP CPU
>code in top.c itself ...
>
>I'll fix this one after lunch.
>

Oops...

I swear, I had not seen five_cpu_numbers when I sent you the patch
about 0.1%...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre9-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
