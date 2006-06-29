Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWF2OZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWF2OZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWF2OZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:25:30 -0400
Received: from www.osadl.org ([213.239.205.134]:63617 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750711AbWF2OZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:25:29 -0400
Subject: Re: NO_HZ Kconfig rework
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Pavel Machek <pavel@ucw.cz>
Cc: Daniel Walker <dwalker@dwalker1.mvista.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060629094231.GA2009@elf.ucw.cz>
References: <200606261616.k5QGGbem016569@dwalker1.mvista.com>
	 <20060629094231.GA2009@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 16:27:38 +0200
Message-Id: <1151591258.25491.621.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

On Thu, 2006-06-29 at 11:42 +0200, Pavel Machek wrote:
> On Mon 2006-06-26 09:16:37, Daniel Walker wrote:
> > I got NO_HZ working on ARM, but because the ARM tree already
> > extensively implements NO_IDLE_HZ I had to make NO_HZ a
> > completely seprate option.
> 
> So... what is the difference between NO_HZ and NO_IDLE_HZ?
> 							Pavel

Mostly a development vehicle. This will be removed once we are ready to
merge the existing arch implementations.

	tglx


