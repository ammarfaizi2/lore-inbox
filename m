Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313798AbSDPSCw>; Tue, 16 Apr 2002 14:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313799AbSDPSCv>; Tue, 16 Apr 2002 14:02:51 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:31383 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S313798AbSDPSCr>; Tue, 16 Apr 2002 14:02:47 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 16 Apr 2002 11:10:09 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: davidm@hpl.hp.com
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <15548.25819.487824.338429@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0204161106030.1460-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, David Mosberger wrote:

> >>>>> On Tue, 16 Apr 2002 10:18:18 -0700 (PDT), Davide Libenzi <davidel@xmailserver.org> said:
>
>   Davide> i still have pieces of paper on my desk about tests done on
>   Davide> my dual piii where by hacking HZ to 1000 the kernel build
>   Davide> time went from an average of 2min:30sec to an average
>   Davide> 2min:43sec. that is pretty close to 10%
>
> Did you keep the timeslice roughly constant?

it was 2.5.1 time and it was still ruled by TICK_SCALE that made the
timeslice to drop from 60ms ( 100HZ ) to 21ms ( 1000HZ ).




- Davide


