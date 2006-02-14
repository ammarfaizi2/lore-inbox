Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422834AbWBNXYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422834AbWBNXYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbWBNXYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:24:10 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:21774 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1422834AbWBNXYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:24:09 -0500
Date: Wed, 15 Feb 2006 00:24:01 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Rob Landley <rob@landley.net>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060214232401.GA83161@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Rob Landley <rob@landley.net>,
	Matthias Andree <matthias.andree@gmx.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <43F1C385.nailMWZ599SQ5@burner> <20060214122333.GA32743@merlin.emma.line.org> <200602141751.02153.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602141751.02153.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 05:51:01PM -0500, Rob Landley wrote:
> I'm only interested in supporting ATA cd burners under a 2.6 or newer kernel, 
> using the DMA method.  (SCSI is dead, I honestly don't care.)  I was hoping I 
> could just open the /dev/cdrom and call the appropriate ioctls on it, but 
> reading the cdrecord source proved enough of an exercise in masochism that I 
> always give up after the first hour and put it back on the todo list.

There may be a chance that cdrdao provides a better starting point,
readability-wise.  It seems to be simpler in what it does, and I've
tended to have a better success rate with it than with cdrecord on
"normal" usage.  Of course, it does not (or did not) include the
advanced usage cdrecord supports (various writing modes, multisession,
who knows what else).

  OG.

