Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030361AbWGTQKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbWGTQKc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 12:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWGTQKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 12:10:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24752 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030356AbWGTQKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 12:10:31 -0400
Date: Thu, 20 Jul 2006 09:09:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz, tk@maintech.de,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: +
 revert-pcmcia-make-ide_cs-work-with-the-memory-space-of-cf-cards-if-io-space-is-not-available.patch
 added to -mm tree
Message-Id: <20060720090957.07681381.akpm@osdl.org>
In-Reply-To: <20060720151202.GQ2038@hexapodia.org>
References: <200607090207.k6927S4D007223@shell0.pdx.osdl.net>
	<20060720151202.GQ2038@hexapodia.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2006 08:12:02 -0700
Andy Isaacson <adi@hexapodia.org> wrote:

> On Sat, Jul 08, 2006 at 07:07:28PM -0700, akpm@osdl.org wrote:
> > The patch titled
> >      revert "pcmcia: Make ide_cs work with the memory space of CF-Cards if IO space is not available"
> > 
> > ------------------------------------------------------
> > Subject: revert "pcmcia: Make ide_cs work with the memory space of CF-Cards if IO space is not available"
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > Two reports (http://lkml.org/lkml/2006/6/15/155 and Pavel) of ide-cs breakage.
> >  I'm suspecting it was this patch but have yet to have confirmation from Pavel
> > or Andy (hint).
> 
> I finally got a chance to test, and 2.6.18-rc1-mm2 does fix my PCMCIA.
> Thanks!
> 

Thanks.  I think that patch has propagated into Dominik's git tree.

Dominik, do you intend to merge that for 2.6.18?
