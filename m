Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQL3Xfi>; Sat, 30 Dec 2000 18:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131617AbQL3Xf2>; Sat, 30 Dec 2000 18:35:28 -0500
Received: from smtp7.xs4all.nl ([194.109.127.133]:42719 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129572AbQL3XfY>;
	Sat, 30 Dec 2000 18:35:24 -0500
Path: Home.Lunix!not-for-mail
Subject: Re: PROBLEM: multiple mount of devices possible 2.4.0-test1 -
    2.4.0-test13-pre4
Date: Sat, 30 Dec 2000 23:04:36 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <Pine.LNX.4.10.10012231103160.2174-100000@penguin.transmeta.com>
NNTP-Posting-Host: kali.eth
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 978217476 24571 10.253.0.3 (30 Dec 2000
    23:04:36 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Sat, 30 Dec 2000 23:04:36 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:66189
X-Mailer: Perl5 Mail::Internet v1.32
Message-Id: <92lpm4$nvr$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10012231103160.2174-100000@penguin.transmeta.com>,
	Linus Torvalds <torvalds@transmeta.com> writes:
> On Sat, 23 Dec 2000 rkreiner@sbox.tu-graz.ac.at wrote:
>> 
>> 1. multiple mount of devices possible 2.4.0-test1 - 2.4.0-test13-pre4
>> 
>> 2. its still possible to mount devices several times.
>>    IMHO it shouldnt be possible like 2.2.18
> 
> No.
> 
> The multi-mount thing is a _major_ feature, and the fact that your "mount"
> binary seems to be confused by it is a user-level problem and nothing
> more.
> 
It should still need a special flag or something, since it's
impossible for userspace to check this atomically.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
