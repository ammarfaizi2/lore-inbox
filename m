Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUIWX6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUIWX6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUIWX6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:58:42 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:50182 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S267552AbUIWXpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:45:25 -0400
Date: Fri, 24 Sep 2004 01:45:20 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Thomas Habets <thomas@habets.pp.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040923234520.GA7303@pclin040.win.tue.nl>
References: <200409230123.30858.thomas@habets.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409230123.30858.thomas@habets.pp.se>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 01:23:08AM +0200, Thomas Habets wrote:

> How about a sysctl that does "for the love of kbaek, don't ever kill these 
> processes when OOM. If nothing else can be killed, I'd rather you panic"?

An aircraft company discovered that it was cheaper to fly its planes
with less fuel on board. The planes would be lighter and use less fuel
and money was saved. On rare occasions however the amount of fuel was
insufficient, and the plane would crash. This problem was solved by
the engineers of the company by the development of a special OOF
(out-of-fuel) mechanism. In emergency cases a passenger was selected
and thrown out of the plane. (When necessary, the procedure was
repeated.)  A large body of theory was developed and many publications
were devoted to the problem of properly selecting the victim to be
ejected.  Should the victim be chosen at random? Or should one choose
the heaviest person? Or the oldest? Should passengers pay in order not
to be ejected, so that the victim would be the poorest on board? And
if for example the heaviest person was chosen, should there be a
special exception in case that was the pilot? Should first class
passengers be exempted?  Now that the OOF mechanism existed, it would
be activated every now and then, and eject passengers even when there
was no fuel shortage. The engineers are still studying precisely how
this malfunction is caused.
