Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030517AbWBOCKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbWBOCKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 21:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWBOCKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 21:10:32 -0500
Received: from smtp.enter.net ([216.193.128.24]:25608 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030517AbWBOCKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 21:10:31 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 21:19:42 -0500
User-Agent: KMail/1.8.1
Cc: Rob Landley <rob@landley.net>, Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <200602141751.02153.rob@landley.net> <20060214232401.GA83161@dspnet.fr.eu.org>
In-Reply-To: <20060214232401.GA83161@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602142119.42981.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 18:24, Olivier Galibert wrote:
> On Tue, Feb 14, 2006 at 05:51:01PM -0500, Rob Landley wrote:
> > I'm only interested in supporting ATA cd burners under a 2.6 or newer
> > kernel, using the DMA method.  (SCSI is dead, I honestly don't care.)  I
> > was hoping I could just open the /dev/cdrom and call the appropriate
> > ioctls on it, but reading the cdrecord source proved enough of an
> > exercise in masochism that I always give up after the first hour and put
> > it back on the todo list.
>
> There may be a chance that cdrdao provides a better starting point,
> readability-wise.  It seems to be simpler in what it does, and I've
> tended to have a better success rate with it than with cdrecord on
> "normal" usage.  Of course, it does not (or did not) include the
> advanced usage cdrecord supports (various writing modes, multisession,
> who knows what else).
>
>   OG.

However it is a C++ application, and I don't know about other people, but for 
various historic reasons I'd rather use C for a command-line application. And 
it isn't free of the masochism related to cdrecord as, the last time I 
checked, cdrdao used libscg.

Now, with that out of the way... cdrdao, in my experience, supports all the 
features, but the last time I used it the documentation for the layout files 
format was scarce and I was unable to figure out how to use it to write an 
ISO file to a disc.

DRH
