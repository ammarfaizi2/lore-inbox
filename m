Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270756AbTHFNXT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274997AbTHFNXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:23:19 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:26514 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S270756AbTHFNXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:23:15 -0400
Date: Wed, 6 Aug 2003 13:06:56 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export touch_nmi_watchdog
Message-ID: <20030806130656.R639@nightmaster.csn.tu-chemnitz.de>
References: <20030805211416.GD31598@colin2.muc.de> <Pine.LNX.4.44.0308051503220.2835-100000@home.osdl.org> <20030806000716.GA68984@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030806000716.GA68984@colin2.muc.de>; from ak@colin2.muc.de on Wed, Aug 06, 2003 at 02:07:16AM +0200
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19kOG0-0005z7-00*pYxUixZ7F8Y*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 02:07:16AM +0200, Andi Kleen wrote:
> On Tue, Aug 05, 2003 at 03:14:00PM -0700, Linus Torvalds wrote:
> > 	#ifdef CONFIG_WATCHDOG
> > 	#warning This driver does bad things and will not work
> > 	#endif
> 
> Well the problem is that many of my multiple CPU testboxes have a fusion
> controller (it's the standard on board chip on the AMD Quartet and Newisys
> systems). 
 
That means, that this driver has a large (paying?) customer base.
This should be enough reason to put some efforts into fixing it.
At least it should for the (big) companies selling servers based
on this chipset, because it will help their customers a lot and
their own support staff finding latency problems.

So if you don't have the time to fix it, it's simply a problem
with your management ignoring its customers ;-/

Regards

Ingo Oeser
