Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUFWXVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUFWXVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUFWXVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:21:08 -0400
Received: from palrel11.hp.com ([156.153.255.246]:55436 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262328AbUFWXUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:20:41 -0400
Date: Wed, 23 Jun 2004 16:20:39 -0700
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [BUG 2.6.7] : Partition table display bogus...
Message-ID: <20040623232039.GA27989@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040623220557.GA26199@bougret.hpl.hp.com> <20040623225640.GE3072@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623225640.GE3072@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 12:56:40AM +0200, Andries Brouwer wrote:
> On Wed, Jun 23, 2004 at 03:05:57PM -0700, Jean Tourrilhes wrote:
> 
> > 	Playing with 2.6.7 on my laptop. I realised Lilo did not work
> > anymore. Look further, and the partition table was all screwed up.
> 
> Not so pessimistic.

	Sorry, I should have said "the partition table display".

> Old situation:
> >  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> New situation:
> >  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> 
> Nothing wrong with that partition table.

	Yep.

> Maybe you get unhappy because of the fdisk output, but that only
> shows that you have an old fdisk. Also there nothing wrong.

	Ok.

> Ah - so the only wrong thing must be the fact that lilo stopped working.
> I suppose things will improve if you give it the "linear" (or "lba32") flag.

	None of these helped. I guess I should update LILO as
well. I'll try to do that.

> What changed is that the kernel no longer attempts at guessing a geometry.
> If such guessing is required, user space must do so itself.
> 
> Andries

	Thanks very much for the quick answer, very helpful !

	Jean
