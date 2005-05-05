Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVEENa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVEENa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 09:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVEENaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 09:30:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:2492 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262108AbVEENaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 09:30:12 -0400
From: Andreas Schwab <schwab@suse.de>
To: linux-os@analogic.com
Cc: Daniel Jacobowitz <dan@debian.org>, Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
References: <4279084C.9030908@free.fr>
	<Pine.LNX.4.61.0505041403310.21458@chaos.analogic.com>
	<20050504191604.GA29730@nevyn.them.org>
	<Pine.LNX.4.61.0505042031120.22323@chaos.analogic.com>
	<Pine.LNX.4.61.0505050814340.24130@chaos.analogic.com>
X-Yow: UH-OH!!  We're out of AUTOMOBILE PARTS and RUBBER GOODS!
Date: Thu, 05 May 2005 15:30:09 +0200
In-Reply-To: <Pine.LNX.4.61.0505050814340.24130@chaos.analogic.com> (Richard
	B. Johnson's message of "Thu, 5 May 2005 08:24:54 -0400 (EDT)")
Message-ID: <jezmv9ream.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <linux-os@analogic.com> writes:

> I don't think the kernel handler gets a chance to do anything
> because SYS-V init installs its own handler(s).

It's impossible to install a handler for SIGSTOP.

> There are comments about Linux misbehavior in the code. It turns out
> that I was right about SIGSTOP and SIGCONT...

No, you are wrong.  SIGTSTP != SIGSTOP.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
