Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUDCThs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 14:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUDCThs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 14:37:48 -0500
Received: from pileup.ihatent.com ([217.13.24.22]:1482 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S261897AbUDCThq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 14:37:46 -0500
To: "Kamil Srot" <kamil.srot@nlogy.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>,
       "Felix von Leitner" <felix-kernel@fefe.de>,
       <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: tg3 error
References: <20040309170945.GA2039@codeblau.de> <404DFB4F.1020208@pobox.com>
	<005401c4195b$ede2f950$4100a8c0@rigel>
From: Alexander Hoogerhuis <alexh@boxed.no>
Date: Sat, 03 Apr 2004 20:56:39 +0200
In-Reply-To: <005401c4195b$ede2f950$4100a8c0@rigel> (Kamil Srot's message of
 "Sat, 3 Apr 2004 11:13:28 +0200")
Message-ID: <87smfkao0o.fsf@dorker.boxed.no>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kamil Srot" <kamil.srot@nlogy.com> writes:

>> Felix von Leitner wrote:
>> > A machine at a customer's site (running kernel 2.4.21) has stopped
>> > answering over Ethernet today.  The machine itself was still there and
>> > the customer could log in at the console.  A reboot fixed the problem.
>> >
>> > The machine has had these error messages in the syslog about once per
>> > hour for about 24 hours:
>> >
>> > Mar  9 16:17:38 mail2 kernel: tg3: eth0: transmit timed out, resetting
>> > Mar  9 16:17:38 mail2 kernel: tg3: tg3_stop_block timed out, ofs=3400
> enable_bit=2
>> > Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=2400
> enable_bit=2
>> > Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=1400
> enable_bit=2
>> > Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=c00
> enable_bit=2
>>
>>
>> AFAIK this is fixed in the latest upstream tg3...
>
> I have exactly the same problems in 2.4.25 - the log says exactly the same
> as for Felix.
> I'm running two identical HP ProLiant servers but have this problem only on
> one of them.
> It's happening approximately twice a week.
>
> Any ideas?
>

Just to pipe in; I have a machine (HP 530cmt) running RHEL3 no the
latest kernel, running with the tg3-driver for the onboard eth, and if
requires the i/f to be taken down and up again to start speaking, or
even negotiating an eth-link. Hardware at the other end is a cisco switch.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@boxed.no
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
