Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263261AbUCTXgN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 18:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbUCTXgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 18:36:13 -0500
Received: from mail.convergence.de ([212.84.236.4]:11656 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263261AbUCTXgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 18:36:12 -0500
Date: Sun, 21 Mar 2004 00:36:04 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040320233604.GE2051@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Matthias Andree <matthias.andree@gmx.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <200403200313.05681.bzolnier@elka.pw.edu.pl> <20040320113627.GB7714@merlin.emma.line.org> <200403201700.05808.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403201700.05808.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 20 of March 2004 12:36, Matthias Andree wrote:
> > > Correct answer is: everything is fine, RTFM (man hdparm). ;-)
> >
> > Not everything is fine. hdparm documents -i returns inconsistent data.
> > Most, but _NOT_ _EVERYTHING_ is cached: the multcount is updated, for
> > instance. What is that good for? Mix & Match whatever is convenient?
> 
> I'm aware of this bug - driver shouldn't modify drive->id.  Patches are welcomed.

Why? What's the reason for keeping out-of-date IDENTIFY data?

And what about ide_driveid_update()? Is it a bug that
it exists?

This is all too confusing for me :-(

Johannes
