Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRKDTLD>; Sun, 4 Nov 2001 14:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRKDTKz>; Sun, 4 Nov 2001 14:10:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16134 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273588AbRKDTKm>; Sun, 4 Nov 2001 14:10:42 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 19:07:53 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9s43m9$doh$1@penguin.transmeta.com>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104163354.C14001@unthought.net> <160QM5-1HAz5sC@fmrl00.sul.t-online.com> <20011104172742Z16629-26013+37@humbolt.nl.linux.org>
X-Trace: palladium.transmeta.com 1004901037 27719 127.0.0.1 (4 Nov 2001 19:10:37 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 4 Nov 2001 19:10:37 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011104172742Z16629-26013+37@humbolt.nl.linux.org>,
Daniel Phillips  <phillips@bonn-fries.net> wrote:
>On November 4, 2001 05:45 pm, Tim Jansen wrote:
>> > The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it
>> > is a list of elements, wherein an element can itself be a list (or a
>> 
>> Why would anybody want a binary encoding? 
>
>Because they have a computer?

That's a stupid argument.

The computer can parse anything. 

It's us _humans_ that are limited at parsing. We like text interfaces,
because that's how we are brought up. We aren't good at binary, and
we're not good at non-linear, "structured" interfaces.

In contrast, a program can be taught to parse the ascii files quite
well, and does not have the inherent limitations we humans have. Sure,
it has _other_ limitations, but /proc being ASCII is sure as hell not
one of them.

In short: /proc is ASCII, and will so remain while I maintain a kernel.
Anything else is stupid.

Handling spaces and newlines is easy enough - see the patches from Al
Viro, for example.

		Linus
