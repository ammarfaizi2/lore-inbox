Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbTA1SBW>; Tue, 28 Jan 2003 13:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbTA1SBV>; Tue, 28 Jan 2003 13:01:21 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:12246 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267393AbTA1SBV>; Tue, 28 Jan 2003 13:01:21 -0500
Date: Tue, 28 Jan 2003 19:10:42 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Martin Mares <mj@ucw.cz>
Cc: Vojtech Pavlik <vojtech@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] in drivers/char/joystick/magellan.c
Message-ID: <20030128181042.GG10685@wohnheim.fh-wedel.de>
References: <20030128155312.GD10685@wohnheim.fh-wedel.de> <20030128175757.GA22145@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030128175757.GA22145@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 January 2003 18:57:57 +0100, Martin Mares wrote:
> 
> As far as I remember, the ANSI C permits initialization of a char array
> with a string of the same length and defines that the trailing \0 is
> dropped in such cases. However, I cannot quote the right chapter and
> verse by heart nor am I sure it's still permitted by C99, so better
> check yourself.

This is interesting, but still dangerous, if the code ever gets
changed. You remember what a Mr. Murphy said about having several
possibilities and one of them leading to a disaster? :)

Jörn

-- 
Beware of bugs in the above code; I have only proved it correct, but
not tried it.
-- Donald Knuth
