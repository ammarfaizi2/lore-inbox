Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUBZUM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbUBZUM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:12:57 -0500
Received: from pat.uio.no ([129.240.130.16]:2782 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262960AbUBZULh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:11:37 -0500
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: Andre Tomt <andre@tomt.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) status report
References: <403D5B3D.6060804@pobox.com>
	<200402261423.56448.m.watts@eris.qinetiq.com>
	<wxxbrnl3lfe.fsf@nommo.uio.no>
	<200402261555.46630.m.watts@eris.qinetiq.com>
From: Terje Kvernes <terjekv@math.uio.no>
Organization: The friends of mr. Tux
X-URL: http://terje.kvernes.no/
Date: Thu, 26 Feb 2004 21:11:30 +0100
In-Reply-To: <200402261555.46630.m.watts@eris.qinetiq.com> (Mark Watts's
 message of "Thu, 26 Feb 2004 15:55:46 +0000")
Message-ID: <wxxsmgxbnyl.fsf@nommo.uio.no>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Watts <m.watts@eris.qinetiq.com> writes:

> > the 3w-xxxx-module works well enough in 32bit mode on AMD64.
> > sadly enough, we have had some other issues with 64bit mode, but
> > the _driver_ seems to load there as well.
> 
> Do these 'issues' prevent the cards from being used at all in 64bit
> mode on AMD-64?

  our issues are mostly related to getting X up and running.  we've
  been looking at keeping most of the userland as 32bit, but still
  running a 64bit kernel.  this works fine, except for the nVidia
  kernel module and its attempt to talk to nVidias openGL libraries.
  it's a very long story.  but, as far as I remember, the 3ware card
  worked fine.
 
> We'd really like to use the 4-port SATA 3Ware card on a Tyan Thunder
> K8W (S2885) but it'd be a bit of a waste if we can only use it in
> 32bit mode. (I assume 32bit mode means you compile for i686 instead
> of AMD-64 ?)

  correct, the kernels on our AMD64-boxes are currently built for
  i686.  I _might_ be able to use one of our FX-51-boxes to test 64bit
  usage of a 3ware PATA controller if you feel you can't take the
  slight gamble.  I'm not quite sure _when_ I can get this done
  though, maybe within a week or two?  but, since you really need to
  test SATA as well, I'd advice you to get a card and test it
  yourself.  I'd be very surprised if it didn't work.

-- 
Terje
