Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267213AbTAOVR5>; Wed, 15 Jan 2003 16:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTAOVR5>; Wed, 15 Jan 2003 16:17:57 -0500
Received: from ns.suse.de ([213.95.15.193]:38925 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267213AbTAOVR4>;
	Wed, 15 Jan 2003 16:17:56 -0500
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
X-Yow: I'm meditating on the FORMALDEHYDE and the ASBESTOS leaking into my
 PERSONAL SPACE!!
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 15 Jan 2003 22:26:48 +0100
In-Reply-To: <20030115164731.GB8621@unthought.net> (Jakob Oestergaard's
 message of "Wed, 15 Jan 2003 17:47:31 +0100")
Message-ID: <jeel7ehzon.fsf@sykes.suse.de>
User-Agent: Gnus/5.09001 (Oort Gnus v0.10) Emacs/21.3.50 (ia64-suse-linux)
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com>
	<87iswrzdf1.fsf@ceramic.fifi.org> <20030114220401.GB241@DervishD>
	<20030114230418.GB4603@doc.pdx.osdl.net>
	<20030114231141.GC4603@doc.pdx.osdl.net>
	<20030115044644.GA18608@mark.mielke.cc>
	<20030115082527.GA22689@pegasys.ws> <20030115114130.GD66@DervishD>
	<20030115131617.GA8621@unthought.net> <20030115162219.GB86@DervishD>
	<20030115164731.GB8621@unthought.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard <jakob@unthought.net> writes:

|> Can anyone point out a problem in the above? I'd be happy to see it shot
|> down, mainly because it's ugly - and I hate programs that mess with
|> argv[0].

argv[0] is not required to point to the actual file name of the
executable, and in fact, most of the time it won't.

Btw, don't use it for setuid programs, it's a huge security hole you can
drive a truck through.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
