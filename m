Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267825AbRGZML1>; Thu, 26 Jul 2001 08:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267784AbRGZMLR>; Thu, 26 Jul 2001 08:11:17 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:12984 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S267859AbRGZMK5>; Thu, 26 Jul 2001 08:10:57 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: IDE "lost interrupt" on SMP
Message-ID: <3B6008D1.8AA2B98F@i.am>
Date: Thu, 26 Jul 2001 12:10:57 GMT
To: Paul Flinders <paul@dawa.demon.co.uk>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B5F4FCA.EF860FF@dawa.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6-RTL3.0 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Paul Flinders wrote:
> However I can't boot any SMP configured kernel. It gets as far as
> the partition check and then starts printing "hd<x>: lost interrupt"
> after than it proceeds _very_ slowly to print the partitions and
> then grinds to a halt as it tries to mount the root fs (I suspect that
> it hasn't actually crashed but that disk I/O is proceeding extremely
> slowly).
> 
> Configuring the kernel for single processor works and boots OK
> - this is true for all the kernels (2.2.x and 2.4.x including 2.4.7)
> that I've tried.

I've been reporting this problem for years 
(since day I've bought SMP board with two Celeron)

However noone seems to care - so you simply can't use SMP kernel
for monoprocessor system - unless Andre Hedric will consider this
is serious problem  (simple test - boot SMP kernel on SMP
computer with cpu=1 or nosmp parameter)

bye

kabi

