Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVGFJFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVGFJFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 05:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVGFJFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 05:05:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:33413 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261657AbVGFHND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 03:13:03 -0400
Date: Tue, 5 Jul 2005 22:26:23 -0700
From: Greg KH <greg@kroah.com>
To: Michal Jaegermann <michal@harddata.com>
Cc: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: A "new driver model" and EXPORT_SYMBOL_GPL question
Message-ID: <20050706052623.GA9881@kroah.com>
References: <20050703171202.A7210@mail.harddata.com> <20050704054441.GA19936@kroah.com> <1120600243.27600.75.camel@localhost> <20050705215739.GA2635@kroah.com> <20050705223743.A28905@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050705223743.A28905@mail.harddata.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 10:37:43PM -0600, Michal Jaegermann wrote:
> On Tue, Jul 05, 2005 at 02:57:40PM -0700, Greg KH wrote:
> > On Tue, Jul 05, 2005 at 03:50:43PM -0600, Zan Lynx wrote:
> > > Sourced from here:
> > > http://hulllug.principalhosting.net/archive/index.php/t-52440.html
> > 
> > No, that is not the same topic or thread.
> 
> Formally you are correct but from my POV this sounds casuistic and
> fit for a patent lawyer.

You must have have dealt with many patent lawyers.  I have, and they
operate in a league of their own on how to intrepret the english
language in patent claims :)

> You were "recently advised not to change
> these symbols" and you stated that you will not. So instead you did
> an end run and you removed an old interface and introduced a
> replacement; but this time with EXPORT_SYMBOL_GPL - which has the
> same effect as what you told you will not do.

I was "advised" to not do so, until the parties that were complaining
about the change, had time to convert their code.  They then did so, and
so, a number of MONTHS later, I did a rewrite of the code, which caused
me to create new functions and delete old, non-used functions.  Those
new functions were marked with the EXPORT_SYMBOL_GPL mark, as ALL of the
driver core functions are.  This change had lived in the -mm tree for a
number of months now, with no objections.

> > If you know of any closed source code, using those functions, please put
> > them in contact with me.
> 
> Well, I gave an example in my original question.  Yes, I asked them
> to contact you.  If they will do that I have no idea.

Thanks for doing so.

greg k-h
