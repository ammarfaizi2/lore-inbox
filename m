Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267629AbTBKLtd>; Tue, 11 Feb 2003 06:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbTBKLtd>; Tue, 11 Feb 2003 06:49:33 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:64137 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267629AbTBKLtc>; Tue, 11 Feb 2003 06:49:32 -0500
Date: Tue, 11 Feb 2003 12:59:07 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Dan Parks <Dan.Parks@CAMotion.com>, SA <no_spam@ntlworld.com>,
       linux-kernel@vger.kernel.org
Subject: Re: interrupt latency ?
Message-ID: <20030211115907.GA29660@wohnheim.fh-wedel.de>
References: <20030210170841.GC1973@wohnheim.fh-wedel.de> <Pine.LNX.3.95.1030210132543.8724A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.3.95.1030210132543.8724A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 February 2003 13:30:49 -0500, Richard B. Johnson wrote:
> On Mon, 10 Feb 2003, [iso-8859-1] J?rn Engel wrote:
> 
> > An assembler interrupt handler that saves registers, tweaks a couple
> > of bits, restores registers and gets the hell out of here should be in
> > the order of 100 cycles, maybe less. Why is linux wasting all this
> > time?
> 
> FYI execution speed and interrupt latency doesn't scale well. You
> are most always I/O bound somewhere.

Ack. It always takes a moment to get used to these facts.

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth
