Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbTCXQZM>; Mon, 24 Mar 2003 11:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264025AbTCXQZM>; Mon, 24 Mar 2003 11:25:12 -0500
Received: from files.ssi.bg ([217.79.71.21]:23563 "HELO files.ssi.bg")
	by vger.kernel.org with SMTP id <S263135AbTCXQZL>;
	Mon, 24 Mar 2003 11:25:11 -0500
Date: Mon, 24 Mar 2003 18:31:27 +0200
From: Alexander Atanasov <alex@ssi.bg>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 AGP no good (VIA KT333, radeon 7500)
Message-Id: <20030324183127.50ad62f9.alex@ssi.bg>
In-Reply-To: <200303241703.25873.duncan.sands@math.u-psud.fr>
References: <200303241703.25873.duncan.sands@math.u-psud.fr>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

On Mon, 24 Mar 2003 17:03:25 +0100
Duncan Sands <duncan.sands@math.u-psud.fr> wrote:

> > (the agpgart: Putting AGP V2 device at 00:00.0 into 1x mode
> > messages have gone too).  The strange thing is, there was no
> > problem with 2.4 even before flashing the BIOS.
> 
> It was not a BIOS problem.  I just went back to an earlier BK tree
> and the problem reappeared.  I must have updated the BK tree
> between tests.  Sorry for the misleading information.

	The default agp speed  in X's radeon driver is 1(cvs from serveral
days) , and seems that X sets that mode. I may have a BIOS problem too
after boot agp speed is undefined, when set to 4 in bios, but in  Option
"AGPMode" "4" changes this, radeon 9000 , kt133 all ok, haven't digged furter.
I've looked at agp changes and this message was added soon there, so this 1x 
may be there from a long time. You can check what the mode is with lspci -vv
too, i've not tested with 2.4, but suspect that you'll see 1x there too.

--
have fun,
alex
