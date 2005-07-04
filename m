Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVGDQHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVGDQHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVGDQHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:07:37 -0400
Received: from mail.harddata.com ([216.123.194.198]:50576 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S261382AbVGDQAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 12:00:32 -0400
Date: Mon, 4 Jul 2005 10:00:22 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A "new driver model" and EXPORT_SYMBOL_GPL question
Message-ID: <20050704100022.A23509@mail.harddata.com>
References: <20050703171202.A7210@mail.harddata.com> <20050704054441.GA19936@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050704054441.GA19936@kroah.com>; from greg@kroah.com on Sun, Jul 03, 2005 at 10:44:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 10:44:41PM -0700, Greg KH wrote:
> On Sun, Jul 03, 2005 at 05:12:02PM -0600, Michal Jaegermann wrote:
> 
> > Was a decision to use EXPORT_SYMBOL_GPL deliberate and if yes then
> > what considerations dictated it, other then the patch author wrote
> > it that way, and what drivers in question are supposed to use when
> > this change will show up in the mainline?  It looks that 2.6.13
> > will do this.
> 
> Please see the archives for the answers to these questions.

I actually tried that before posting.  Maybe I attempted to look for
wrong things but, beyond conversion examples, I found some postings
with a general theme "there is no point to make life easy for
binary-only modules" and not much else.  I am afraid that this
leaves me not much wiser.

Also, at least when dealing with 2.6.13-r1, neither
Documentation/feature-removal-schedule.txt, nor files in
Documentation/driver-model/ directory, mention anything about a
switch to EXPORT_SYMBOL_GPL for relevant symbols.  The only thing I
can find about the later in "feature-removal..." is a note about RCU
API.

   Michal
