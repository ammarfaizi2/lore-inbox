Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbSIPVFc>; Mon, 16 Sep 2002 17:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbSIPVFc>; Mon, 16 Sep 2002 17:05:32 -0400
Received: from smtpout.mac.com ([204.179.120.97]:55254 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S263012AbSIPVFb>;
	Mon, 16 Sep 2002 17:05:31 -0400
Date: Mon, 16 Sep 2002 23:10:16 +0200
Subject: Re: Oops in sched.c on PPro SMP
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, mingo@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Peter Waechtler <pwaechtler@mac.com>
In-Reply-To: <1032187767.1191.16.camel@irongate.swansea.linux.org.uk>
Message-Id: <B2E24D20-C9B8-11D6-8873-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag den, 16. September 2002, um 16:49, schrieb Alan Cox:

> On Mon, 2002-09-16 at 15:25, Peter Waechtler wrote:
>> I suffered from lockups on PPro SMP as I switched from 2.4.18-SuSE
>> to 2.4.19 and 2.4.20-pre7
>
> What compiler did you build it with ? I've seen oopses like this from
> gcc 3.0.x that went away with gcc 3.2, 2.95 or 2.96
>
> Also does turning off the nmi watchdog junk make the box stable ?
>

It's 2.95.3:

Reading specs from /usr/lib/gcc-lib/i486-suse-linux/2.95.3/specs
gcc version 2.95.3 20010315 (SuSE)

But I will check the readlocks more closely.

