Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUJIVfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUJIVfe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUJIVfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:35:34 -0400
Received: from mail.broadpark.no ([217.13.4.2]:60413 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S267417AbUJIVf1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:35:27 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
References: <41677E4D.1030403@mvista.com> <yw1xk6u0hw2m.fsf@mru.ath.cx>
	<1097356829.1363.7.camel@krustophenia.net>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Date: Sat, 09 Oct 2004 23:35:16 +0200
In-Reply-To: <1097356829.1363.7.camel@krustophenia.net> (Lee Revell's
 message of "Sat, 09 Oct 2004 17:20:30 -0400")
Message-ID: <yw1xis9ja82z.fsf@mru.ath.cx>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Sat, 2004-10-09 at 09:15, M�ns Rullg�rd wrote:
>> I got this thing to build by adding a few EXPORT_SYMBOL, patch below.
>> Now it seems to be running quite well.  I am, however, getting
>> occasional "bad: scheduling while atomic!" messages, all alike:
>> 
>
> I am getting the same message.   Also, leaving all the default debug
> options on, I got this debug output, but it did not coincide with the
> "bad" messages.
>
> Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
> Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
> Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
> Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
> Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
> Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)

Well, those don't give me any clues.

I had the system running that kernel for a bit over an hour and got
five of the "bad" messages, approximately evenly spaced in a
two-minute interval about 20 minutes after boot.

I did notice one improvement compared to vanilla 2.6.8.1.  The sound
didn't skip when I switched from X to a text console.  However, my
keyboard no longer worked in X, but that seems to be due to some
recent changes to the input subsystem.

Did you build it with our without my patch, BTW?

-- 
M�ns Rullg�rd
mru@mru.ath.cx
