Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbTAOVzH>; Wed, 15 Jan 2003 16:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTAOVzG>; Wed, 15 Jan 2003 16:55:06 -0500
Received: from [66.70.28.20] ([66.70.28.20]:32264 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267374AbTAOVzF>; Wed, 15 Jan 2003 16:55:05 -0500
Date: Wed, 15 Jan 2003 23:03:17 +0100
From: DervishD <raul@pleyades.net>
To: Andreas Schwab <schwab@suse.de>
Cc: Jakob Oestergaard <jakob@unthought.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115220317.GL47@DervishD>
References: <20030114220401.GB241@DervishD> <20030114230418.GB4603@doc.pdx.osdl.net> <20030114231141.GC4603@doc.pdx.osdl.net> <20030115044644.GA18608@mark.mielke.cc> <20030115082527.GA22689@pegasys.ws> <20030115114130.GD66@DervishD> <20030115131617.GA8621@unthought.net> <20030115162219.GB86@DervishD> <20030115164731.GB8621@unthought.net> <jeel7ehzon.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jeel7ehzon.fsf@sykes.suse.de>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Andreas :)

> |> down, mainly because it's ugly - and I hate programs that mess with
> |> argv[0].
> argv[0] is not required to point to the actual file name of the
> executable, and in fact, most of the time it won't.
> Btw, don't use it for setuid programs, it's a huge security hole you can
> drive a truck through.

    Yes, I suppose that exec'ing whatever is in argv0 is not a good
idea :((( Didn't think about it.

    Any suggestion on how to get the binary name from the core image?

    Thanks a lot for the warning, Andreas :)

    Raúl
