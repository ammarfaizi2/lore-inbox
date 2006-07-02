Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWGBLib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWGBLib (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 07:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWGBLia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 07:38:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29356 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964870AbWGBLia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 07:38:30 -0400
Subject: Re: Oops / BUG? (2.6.17.2 on VIA Epia CL6000)
From: Arjan van de Ven <arjan@infradead.org>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44A7ACF2.4070304@xs4all.nl>
References: <44A7AADB.8040106@xs4all.nl>
	 <1151839268.3111.10.camel@laptopd505.fenrus.org>
	 <44A7ACF2.4070304@xs4all.nl>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 13:38:28 +0200
Message-Id: <1151840308.3111.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 13:24 +0200, Udo van den Heuvel wrote:
> Arjan van de Ven wrote:
> > On Sun, 2006-07-02 at 13:15 +0200, Udo van den Heuvel wrote:
> >> Hello,
> >>
> >> On my otherwise stable Via EPIA CL6000 I experienced an OOPS.
> >> Hardware should be OK. I was unable to reproduce the event, so far.
> >> In what part of the kernel did things go wrong?
> >> What can I do to help fix the bug? (if it is indeed a bug)
> > 
> > Hi,
> > 
> > something really bad happened (the processor jumped into hyperspace);
> > however it looks like automatic symbol resolving isn't working;
> > could you check if CONFIG_KALLSYMS is enabled in your kernel config?
> > With that enabled, debugability tends to go up bigtime since at least
> > the backtrace becomes human readable...
> 
> I have:
> 
> CONFIG_KALLSYMS=y

Hoi,

hmmmmm then something really bad happened, so bad that even the
backtrace is corrupted ;(

I'm sorry to say but unless you already have a suspect, those are really
really hard to diagnose or fix. One thing you can do is remove all
modules you don't actually use (just from a statistical pov that reduces
the risk of it repeating)... and hope maybe a next backtrace does
provide more information.

Greetings,
    Arjan van de Ven

