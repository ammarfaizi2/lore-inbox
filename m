Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318926AbSIITLy>; Mon, 9 Sep 2002 15:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318928AbSIITLy>; Mon, 9 Sep 2002 15:11:54 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:14088 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S318926AbSIITLs>; Mon, 9 Sep 2002 15:11:48 -0400
Date: Mon, 9 Sep 2002 20:16:26 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Cc: jonathan@buzzard.org.uk
Subject: Re: [Patch] 2.5.34 IRQ Patch
Message-ID: <20020909191626.GA59685@compsoc.man.ac.uk>
References: <20020909120451.GA23868@comet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909120451.GA23868@comet>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 08:04:52AM -0400, James Blackwell wrote:

> A note to those that are a bit rough on kernel patch newbies.... submitting 
> a kernel patch for the very first time is a rather intimidating experience
> so please don't chew my head off unless its absolutely necessary. 

I didn't look at this particular case, but the fixes are generally
not as simple as just replacing them mechanically. You need to ensure
that things are still properly locked wrt the interrupt handler since
the semantics have changed. See the discussion in the mail archives

regards
john
-- 
"This *is* Usenet, after all, where virtually every conversation that goes on
is fairly ludicrous in the first place."
	- Godwin's Law FAQ
