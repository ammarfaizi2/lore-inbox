Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVATABO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVATABO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVASX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:57:31 -0500
Received: from orb.pobox.com ([207.8.226.5]:13770 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261991AbVASXyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:54:12 -0500
Date: Wed, 19 Jan 2005 15:54:02 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050119235402.GB4471@ip68-4-98-123.oc.oc.cox.net>
References: <20050114002352.5a038710.akpm@osdl.org> <20050114150714.GA4501@ip68-4-98-123.oc.oc.cox.net> <Pine.LNX.4.61.0501192301370.8199@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501192301370.8199@student.dei.uc.pt>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 11:06:10PM +0000, Marcos D. Marado Torres wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Fri, 14 Jan 2005, Barry K. Nathan wrote:
> 
> >This isn't new to 2.6.11-rc1-mm1, but it has the infamous (to Fedora
> >users) "ACPI shutdown bug" -- poweroff hangs instead of actually turning
> >the computer off, on some computers. Here's the RH Bugzilla report where
> >most of the discussion took place:
> >
> >https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=132761
> 
> This is the same bug I've talked here:
> http://lkml.org/lkml/2005/1/11/88

FWIW the RH Bugzilla bug is (unfortunately) discussing several different
similar but not identical bugs, as far as I can tell.

> This only happens with -mm and not with vanilla sources.
> 
> I'm reporting about this issue in an ASUS M3N laptop with Debian.
> 
> Best regards,
> Mind Booster Noori

FWIW my report against -mm (where I narrowed it down to one of the kexec
patches in particular) is here:
http://bugme.osdl.org/show_bug.cgi?id=4041

-Barry K. Nathan <barryn@pobox.com>

