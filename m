Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbSALJoB>; Sat, 12 Jan 2002 04:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSALJnw>; Sat, 12 Jan 2002 04:43:52 -0500
Received: from david.siemens.de ([192.35.17.14]:32979 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S284300AbSALJnp> convert rfc822-to-8bit;
	Sat, 12 Jan 2002 04:43:45 -0500
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Hood <jdthood@mail.com>, Russell King <rmk@arm.linux.org.uk>,
        Andreas Steinmetz <ast@domdv.de>, linux-laptop@vger.kernel.org,
        laslo@wodip.opole.pl, linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Combined APM patch
In-Reply-To: <20020107155226.5c6409b6.sfr@canb.auug.org.au>
In-Reply-To: <20020107155226.5c6409b6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Jan 2002 12:43:30 +0300
Message-Id: <1010828612.2501.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ðÎÄ, 2002-01-07 at 07:52, Stephen Rothwell wrote:
> Hi All,
> 
> This is my version of the combined APM patches;
> 
> 	Change notification order so that user mode is notified
> 		before drivers of impending suspends.
> 	Move the idling back into the idle loop.
> 	A couple of small tidy ups.
> 
> See header comments for attributions.
> 
> This works for me (including as a module).
> 
> Please test and let me know - it seems to lower my power requirements
> by about 10% on my Thinkpad (over stock 2.4.17).
> 
> http://www.canb.auug.org.au/~sfr/2.4.17-APM.1.diff
> 

Sorry for delay.

The patch works just fine here. The only comment is not related to your
patch - before I did not use this interrupt counting and I have feeling
that CPU temp went down faster when system became idle. I still do not
understand what is achieved by it.

regards

-andrej
