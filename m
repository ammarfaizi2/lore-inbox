Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWCMTgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWCMTgR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWCMTgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:36:17 -0500
Received: from smtp-2.llnl.gov ([128.115.3.82]:4348 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S932365AbWCMTgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:36:16 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Doug Thompson <dthompson@lnxi.com>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Mon, 13 Mar 2006 11:35:35 -0800
User-Agent: KMail/1.5.3
Cc: arjan@infradead.org, greg@kroah.com, gregkh@kroah.com,
       bluesmoke-devel@lists.sourceforge.net,
       Doug Thompson <dthompson@lnxi.com>, torvalds@osdl.org, alan@redhat.com,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net
References: <4412A0AB02000036000015D4@zoot.lnxi.com>
In-Reply-To: <4412A0AB02000036000015D4@zoot.lnxi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131135.35531.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2006 09:04, Doug Thompson wrote:
> > > >     - When an error is actually detected, the subsystem that detected
> > > >       the error (for instance, PCI) would feed the error information
> > > >       to EDAC.  Then EDAC would determine how to respond to the error
> > > >       (for instance, push it to userspace or implement the
> > > >       userspace-chosen policy (panic/reboot/etc))
> > >
> > > yup.
> >
> > Cool!  I think this also coincides with what Doug is saying.  Doug, how
> > does this sound?
>
> It sounds good. One issue is how this works with the IBM PCI Parity
> handling submission? I don't remember if it has been included yet or
> not. I haven't fully studied their model, but it allowed for device
> drivers to register notification functions. The PCI subsystem would then
> notify the driver of such errors so the driver could do what ever it
> needed to do in the bad-thing-happened event.

Hmm... interesting.  Can you provide any links to info on this?

