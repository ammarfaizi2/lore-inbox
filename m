Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRHJHbL>; Fri, 10 Aug 2001 03:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264669AbRHJHbB>; Fri, 10 Aug 2001 03:31:01 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:40196 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S264375AbRHJHas>; Fri, 10 Aug 2001 03:30:48 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux@horizon.com
Date: Fri, 10 Aug 2001 09:30:47 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.7: random.c - potential security problem
CC: linux-kernel@vger.kernel.org
Message-ID: <3B73A9C7.19685.5F525A@localhost>
In-Reply-To: <20010810070319.10233.qmail@science.horizon.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/3.47+2.4+2.03.072+02 July 2001+64930@20010810.072842Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Aug 2001, at 7:03, linux@horizon.com wrote:

> The test is "if ((t - rekey_time) > REKEY_INTERVAL)", where rekey_time is *unsigned*.
> 
> Thus, if t ever drops below rekey_time (large backward time jump), the difference
> will be a large number and it will be rekeyed.

Thanks,

first at school they try to teach you about negative numbers, then with 
computers you have to forget about them again. Sorry abou the 
confusion, I never felt save with type promotion rules in C.

> 
> Setting the time back by a small amount, less than REKEY_INTERVAL, can stretch the time,
> but it's hard to think if a reasonable application where that will happen often enough
> in a row to seriously stretch the rekey interval.

Yes!

Ulrich

