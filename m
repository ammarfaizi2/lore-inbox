Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312393AbSDPLZR>; Tue, 16 Apr 2002 07:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312458AbSDPLZQ>; Tue, 16 Apr 2002 07:25:16 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:10756 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S312393AbSDPLZP>; Tue, 16 Apr 2002 07:25:15 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 16 Apr 2002 12:35:49 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Wade <lkml@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre7
Message-ID: <20020416123549.A16359@bytesex.org>
In-Reply-To: <Pine.LNX.4.21.0204160049130.18896-100000@freak.distro.conectiva> <slrnabnps8.evm.kraxel@bytesex.org> <20020416200032.14fbd436.lkml@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 16 10:44:42 bogomips agetty[1111]: ttyS0: ioctl: Input/output error
> > Apr 16 10:44:52 bogomips init: Id "S0" respawning too fast: disabled
> > for 5 minutes
> 
> Hi, I found that my ttyS0 had turned into ttyS1 :-) My modem was
> unresponsive, until I changed the setting to use ttyS1, hope this helps.

Making getty using ttyS1 works for me too, I have my login prompt back.
Looks like a off-by-one bug ...

  Gerd

-- 
#include </dev/tty>
