Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267668AbTAXOcU>; Fri, 24 Jan 2003 09:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267674AbTAXOcU>; Fri, 24 Jan 2003 09:32:20 -0500
Received: from ns.suse.de ([213.95.15.193]:33291 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267668AbTAXOcU>;
	Fri, 24 Jan 2003 09:32:20 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Mark Mielke <mark@mark.mielke.cc>,
       Davide Libenzi <davidel@xmailserver.org>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
X-Yow: I'm wet!  I'm wild!
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 24 Jan 2003 15:41:29 +0100
In-Reply-To: <20030123221858.GA8581@bjl1.asuk.net> (Jamie Lokier's message
 of "Thu, 23 Jan 2003 22:18:58 +0000")
Message-ID: <jefzripq3q.fsf@sykes.suse.de>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.3.50 (ia64-suse-linux)
References: <20030122065502.GA23790@math.leidenuniv.nl>
	<20030122080322.GB3466@bjl1.asuk.net>
	<Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com>
	<20030123154304.GA7665@bjl1.asuk.net>
	<20030123172734.GA2490@mark.mielke.cc>
	<20030123182831.GA8184@bjl1.asuk.net>
	<20030123204056.GC2490@mark.mielke.cc>
	<20030123221858.GA8581@bjl1.asuk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

|> (Davide), IMHO epoll should decide whether it means "at minimum" (in
|> which case the +1 is a requirement), or it means "at maximum" (in
|> which case rounding up is wrong).

Since Linux isn't a RTOS you can't meet "at maximum".  POSIX says "poll ()
shall wait at least timeout milliseconds"

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
