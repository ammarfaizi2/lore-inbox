Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUJJAFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUJJAFk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267661AbUJJAFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:05:40 -0400
Received: from mail.broadpark.no ([217.13.4.2]:63475 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S267653AbUJJAFa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:05:30 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
References: <41677E4D.1030403@mvista.com> <yw1xk6u0hw2m.fsf@mru.ath.cx>
	<1097356829.1363.7.camel@krustophenia.net>
	<yw1xis9ja82z.fsf@mru.ath.cx>
	<1097365941.1363.31.camel@krustophenia.net>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Date: Sun, 10 Oct 2004 02:05:18 +0200
In-Reply-To: <1097365941.1363.31.camel@krustophenia.net> (Lee Revell's
 message of "Sat, 09 Oct 2004 19:52:22 -0400")
Message-ID: <yw1xfz4n8mkh.fsf@mru.ath.cx>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Sat, 2004-10-09 at 17:35, Måns Rullgård wrote:
>> Lee Revell <rlrevell@joe-job.com> writes:
>> 
>> > On Sat, 2004-10-09 at 09:15, Måns Rullgård wrote:
>> >> I got this thing to build by adding a few EXPORT_SYMBOL, patch below.
>> >> Now it seems to be running quite well.  I am, however, getting
>> >> occasional "bad: scheduling while atomic!" messages, all alike:
>> >> 
>> >
>> > I am getting the same message.   Also, leaving all the default debug
>> > options on, I got this debug output, but it did not coincide with the
>> > "bad" messages.
>> >
>> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
>> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
>> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
>> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
>> > Mtx: dd84e644 [773] pri (0) inherit from [3] pri(92)
>> > Mtx dd84e644 task [773] pri (92) restored pri(0). Next owner [3] pri (92)
>> 
>> Well, those don't give me any clues.
>
> Pid 773 is the IRQ thread for eth0.  I am using the via-rhine driver.

I was using a prism54 wireless card.

-- 
Måns Rullgård
mru@mru.ath.cx
