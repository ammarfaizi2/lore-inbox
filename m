Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265595AbUABQmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 11:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265596AbUABQmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 11:42:13 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:11173 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265595AbUABQmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 11:42:09 -0500
Date: Fri, 2 Jan 2004 17:42:06 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Libor Vanek <libor@conet.cz>
Cc: Ragnar Kj?rstad <kernel@ragnark.vestdata.no>, linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040102164206.GE31489@wohnheim.fh-wedel.de>
References: <3FF56B1C.1040308@conet.cz> <20040102135713.GA9935@vestdata.no> <3FF59098.3030904@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FF59098.3030904@conet.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 January 2004 16:39:04 +0100, Libor Vanek wrote:
> >
> The code looks very nice'n'simple but it won't run on 2.6 because 
> mentioned hidden sys_call_table. But I can imagine that this with some 
> small tweaks can be integrated into 2.6 to provide generall 
> infrastructure for syscall hijacking when really needed.

Repeat: This is a hack, nothing else.

*You* need it for your thesis, so go ahead.  The right solution for
the problem, which is research, rather than engineering.  But don't
think this mess should be integrated into mainline, much less tell
other people it should.

*Noone* needs it for real code that is supposed to do something
meaningful.  Some people feel they need it, but they just haven't
found the right solution yet and believe this hack to be right.  It
isn't.

Clear enough?

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
