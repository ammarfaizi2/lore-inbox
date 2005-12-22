Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbVLVNZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbVLVNZS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVLVNZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:25:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55427 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965152AbVLVNZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:25:15 -0500
Date: Thu, 22 Dec 2005 05:24:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: oliver@neukum.org, rlrevell@joe-job.com, dax@gurulabs.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: ETA for Areca RAID driver (arcmsr) in mainline?
Message-Id: <20051222052443.57ffe6f9.akpm@osdl.org>
In-Reply-To: <1135239601.2940.5.camel@laptopd505.fenrus.org>
References: <1135228831.4122.15.camel@mentorng.gurulabs.com>
	<1135229681.439.23.camel@mindpipe>
	<200512220917.41494.oliver@neukum.org>
	<1135239601.2940.5.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Thu, 2005-12-22 at 09:17 +0100, Oliver Neukum wrote:
> > Am Donnerstag, 22. Dezember 2005 06:34 schrieb Lee Revell:
> > > On Wed, 2005-12-21 at 22:20 -0700, Dax Kelson wrote:
> > > > I just got a shiny new (for me at least, the card has been out for
> > > > months) Areca RAID card.
> > > > 
> > > > The driver (arcmsr) is in the -mm kernel, but hasn't yet made it to the
> > > > mainline kernel. I'm curious what remains to be done before this can
> > > > happen?
> > > 
> > > Well, often all that's needed are some user reports that the driver
> > > works for them.
> > 
> > Is that a reasonable strategy? Why is a _new_ driver present only in -mm?
> > It hardly can break anything. It is possible that Andrew is quicker merging
> > but still I can't see the advantage if this persists for any length of time.
> 
> afaik that's not the strategy here.
> It's more "we're waiting for the structural issues to be resolved" which
> sounds quite reasonable.
> 

Yes, there are lots of stylistic and API-usage issues with the driver and
it needs someone to fix them all up.  Unfortunately the original
developer's English is very poor and he's obviously quite unfamiliar with
how Linux development happens.

This is all resolveable - it just needs someone to get down and work with
Erich on knocking the driver into shape.  But as yet, nobody has stepped up
to do that work.

And yes, the driver does apparently work.
